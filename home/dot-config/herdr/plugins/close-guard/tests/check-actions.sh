#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmpdir="$(mktemp -d "${TMPDIR:-/tmp}/herdr-close-guard.XXXXXX")"
trap 'rm -rf "$tmpdir"' EXIT

log_file="$tmpdir/herdr.log"
fake_herdr="$tmpdir/herdr"

# Workspace w1 ("dotfiles") has tab w1:t1 ("1": panes w1:p1, w1:p2) and tab
# w1:t2 ("2": pane w1:p3). CLOSE_GUARD_TEST_BUSY lists the panes running
# opencode. Calls are logged one per line, with newlines shown as "\n" and
# field separators as " | ".
cat >"$fake_herdr" <<'HERDR'
#!/usr/bin/env bash
set -euo pipefail

line="$*"
line="${line//$'\n'/\\n}"
printf '%s\n' "${line//$'\x1f'/ | }" >>"$CLOSE_GUARD_TEST_LOG"

case "${1:-} ${2:-}" in
"pane process-info")
  pane="$4"
  if [[ "${CLOSE_GUARD_TEST_UNAVAILABLE:-}" == "$pane" ]]; then
    exit 1
  elif [[ "${CLOSE_GUARD_TEST_GARBAGE:-}" == "$pane" ]]; then
    printf '%s\n' 'not json'
  elif [[ "${CLOSE_GUARD_TEST_DOUBLE:-}" == "$pane" ]]; then
    printf '%s\n' '{"result":{"process_info":{"foreground_processes":[{"name":"zsh"}]}}}' \
      '{"result":{"process_info":{"foreground_processes":[{"name":"zsh"}]}}}'
  elif [[ "${CLOSE_GUARD_TEST_SCRIPT:-}" == "$pane" ]]; then
    printf '%s\n' '{"result":{"process_info":{"shell_pid":1,"foreground_process_group_id":5,
      "foreground_processes":[{"name":"bash","pid":5,"argv":["bash","deploy.sh"]}]}}}'
  elif [[ " ${CLOSE_GUARD_TEST_BUSY:-} " == *" $pane "* ]]; then
    printf '%s\n' '{"result":{"process_info":{"foreground_processes":[{"name":"opencode"}]}}}'
  else
    printf '%s\n' '{"result":{"process_info":{"foreground_processes":[{"name":"-zsh"}]}}}'
  fi
  ;;
"api snapshot")
  [[ "${CLOSE_GUARD_TEST_LIST_FAILS:-}" == 1 ]] && exit 1
  # CLOSE_GUARD_TEST_HIDDEN drops a pane from the snapshot's pane list.
  printf '%s\n' '{"result":{"snapshot":{
    "panes":[
      {"pane_id":"w1:p1","tab_id":"w1:t1","workspace_id":"w1","agent":null,"terminal_title_stripped":"first"},
      {"pane_id":"w1:p2","tab_id":"w1:t1","workspace_id":"w1","agent":"claude","terminal_title_stripped":"second\tpane"},
      {"pane_id":"w1:p3","tab_id":"w1:t2","workspace_id":"w1","terminal_title":"\u001b[1mthird\u0007"},
      {"pane_id":"w2:p1","tab_id":"w2:t1","workspace_id":"w2","terminal_title_stripped":"elsewhere"}],
    "tabs":[
      {"tab_id":"w1:t1","label":"1","pane_count":2},{"tab_id":"w1:t2","label":"2","pane_count":1},
      {"tab_id":"w2:t1","label":"1"}],
    "workspaces":[{"workspace_id":"w1","label":"dotfiles","pane_count":3}]}}}' |
    grep -v "\"pane_id\":\"${CLOSE_GUARD_TEST_HIDDEN:-none}\""
  ;;
"pane close" | "tab close" | "workspace close" | "plugin pane") ;;
*)
  printf 'Unexpected Herdr command: %s\n' "$*" >&2
  exit 2
  ;;
esac
HERDR
chmod +x "$fake_herdr"

fail() {
  printf '%s\n' "$1" >&2
  printf 'Herdr calls:\n' >&2
  cat "$log_file" >&2
  exit 1
}

# run_close <scope> <target> [VAR=value...]
run_close() {
  local scope="$1" target="$2"
  shift 2
  : >"$log_file"
  env -u HERDR_PANE_ID -u HERDR_TAB_ID -u HERDR_WORKSPACE_ID \
    CLOSE_GUARD_TEST_LOG="$log_file" \
    HERDR_BIN_PATH="$fake_herdr" \
    HERDR_PLUGIN_ID=local.close-guard \
    HERDR_PLUGIN_CONTEXT_JSON="{\"${scope}_id\":\"$target\"}" \
    "$@" \
    bash "$script_dir/close.sh" "$scope"
}

expect_closed() {
  grep -Fxq "$1 close $2" "$log_file" || fail "Expected $1 $2 to be closed."
  if grep -Fq 'plugin pane open' "$log_file"; then
    fail "Closing $1 $2 unexpectedly asked for confirmation."
  fi
}

# expect_confirmation <scope> <target> <heading> <context> <rows>
expect_confirmation() {
  local expected
  expected="plugin pane open --plugin local.close-guard --entrypoint confirm-close"
  expected+=" --env CLOSE_GUARD_SCOPE=$1 --env CLOSE_GUARD_TARGET=$2"
  expected+=" --env CLOSE_GUARD_HEADING=$3 --env CLOSE_GUARD_CONTEXT=$4 --env CLOSE_GUARD_ROWS=$5"
  grep -Fxq "$expected" "$log_file" || fail "Expected confirmation: $expected"
  if grep -Eq '^(pane|tab|workspace) close ' "$log_file"; then
    fail "$1 $2 was closed without confirmation."
  fi
}

run_close pane w1:p1
expect_closed pane w1:p1
run_close pane w1:p1 CLOSE_GUARD_TEST_BUSY=w1:p1
expect_confirmation pane w1:p1 'Close pane?' 'tab 1 · dotfiles' 'opencode | first'
run_close pane w1:p2 CLOSE_GUARD_TEST_BUSY=w1:p2
expect_confirmation pane w1:p2 'Close pane?' 'tab 1 · dotfiles' 'claude | second pane'
run_close pane w1:p1 CLOSE_GUARD_TEST_UNAVAILABLE=w1:p1
expect_confirmation pane w1:p1 'Close pane?' 'tab 1 · dotfiles' 'unknown | first'
# The pane is still checked when it cannot be listed.
run_close pane w1:p1 CLOSE_GUARD_TEST_LIST_FAILS=1
expect_closed pane w1:p1
run_close pane w1:p1 CLOSE_GUARD_TEST_LIST_FAILS=1 CLOSE_GUARD_TEST_BUSY=w1:p1
expect_confirmation pane w1:p1 'Close pane?' '' 'opencode | '

# HERDR_PANE_ID takes precedence over the invocation context.
: >"$log_file"
CLOSE_GUARD_TEST_LOG="$log_file" HERDR_BIN_PATH="$fake_herdr" HERDR_PANE_ID=w1:p2 \
  HERDR_PLUGIN_CONTEXT_JSON='{"pane_id":"w1:p1"}' bash "$script_dir/close.sh" pane
expect_closed pane w1:p2

run_close tab w1:t1
expect_closed tab w1:t1
# A busy pane in another tab does not affect this one.
run_close tab w1:t1 CLOSE_GUARD_TEST_BUSY=w1:p3
expect_closed tab w1:t1
run_close tab w1:t1 CLOSE_GUARD_TEST_BUSY="w1:p1 w1:p2"
expect_confirmation tab w1:t1 'Close tab 1?' dotfiles 'opencode | first\nclaude | second pane'
run_close tab w1:t1 CLOSE_GUARD_TEST_UNAVAILABLE=w1:p2
expect_confirmation tab w1:t1 'Close tab 1?' dotfiles 'unknown | second pane'
# Unparseable output still asks.
run_close tab w1:t1 CLOSE_GUARD_TEST_GARBAGE=w1:p2
expect_confirmation tab w1:t1 'Close tab?' '' 'unknown | could not inspect panes'
# Extra output from one pane must not be read as the next pane's.
run_close tab w1:t1 CLOSE_GUARD_TEST_DOUBLE=w1:p1 CLOSE_GUARD_TEST_BUSY=w1:p2
expect_confirmation tab w1:t1 'Close tab 1?' dotfiles 'unknown | could not inspect panes'
# A shell running a script is busy, even though only a shell is in the foreground.
run_close tab w1:t1 CLOSE_GUARD_TEST_SCRIPT=w1:p1
expect_confirmation tab w1:t1 'Close tab 1?' dotfiles 'bash | first'
# A pane missing from the snapshot is reported rather than skipped.
run_close tab w1:t1 CLOSE_GUARD_TEST_HIDDEN=w1:p2
expect_confirmation tab w1:t1 'Close tab 1?' dotfiles 'unknown | 2 panes expected, 1 listed'
run_close tab w1:t1 CLOSE_GUARD_TEST_LIST_FAILS=1
expect_confirmation tab w1:t1 'Close tab w1:t1?' '' 'unknown | could not list panes'
run_close tab w1:t9
expect_confirmation tab w1:t9 'Close tab w1:t9?' '' 'unknown | could not list panes'

run_close workspace w1
expect_closed workspace w1
run_close workspace w1 CLOSE_GUARD_TEST_BUSY="w1:p3 w2:p1"
expect_confirmation workspace w1 'Close workspace dotfiles?' '2 tabs · 3 panes' 'opencode |  [1mthird '
run_close workspace w2 CLOSE_GUARD_TEST_BUSY=w2:p1
expect_confirmation workspace w2 'Close workspace w2?' '1 tab · 1 pane' 'opencode | elsewhere'

: >"$log_file"
if CLOSE_GUARD_TEST_LOG="$log_file" HERDR_BIN_PATH="$fake_herdr" bash "$script_dir/close.sh" window 2>/dev/null; then
  fail 'Unknown scope was accepted.'
fi
[[ -s "$log_file" ]] && fail 'Unknown scope invoked Herdr.'

# confirm <scope> <answer> [VAR=value...]: runs the popup and prints its output.
confirm() {
  local scope="$1" answer="$2"
  shift 2
  : >"$log_file"
  printf '%s' "$answer" | env CLOSE_GUARD_TEST_LOG="$log_file" HERDR_BIN_PATH="$fake_herdr" \
    CLOSE_GUARD_SCOPE="$scope" CLOSE_GUARD_TARGET=target "$@" \
    bash "$script_dir/confirm-close.sh"
}

for scope in pane tab workspace; do
  confirm "$scope" y >/dev/null
  grep -Fxq "$scope close target" "$log_file" || fail "Confirming did not close $scope."
  confirm "$scope" n >/dev/null
  [[ -s "$log_file" ]] && fail "Declining confirmation for $scope invoked Herdr."
  confirm "$scope" '' >/dev/null
  [[ -s "$log_file" ]] && fail "Pressing enter for $scope invoked Herdr."
done

output="$(confirm tab n COLUMNS=30 LINES=7 TERM=dumb \
  CLOSE_GUARD_HEADING='Close tab 1?' CLOSE_GUARD_CONTEXT=dotfiles \
  CLOSE_GUARD_ROWS=$'opencode\x1fa very long pane title indeed\nclaude\x1fsecond\nnvim\x1fthird')"
expected=$' Close tab 1?\n dotfiles\n\n   opencode  a very long pane…\n   + 2 more\n\n y close  ·  any other key cancels'
[[ "$output" == "$expected" ]] || fail "Unexpected popup output:"$'\n'"$output"

# Truncation counts characters even without a UTF-8 locale.
output="$(confirm tab n COLUMNS=30 LINES=7 TERM=dumb LC_ALL=C \
  CLOSE_GUARD_HEADING='Close tab 1?' CLOSE_GUARD_CONTEXT=dotfiles \
  CLOSE_GUARD_ROWS=$'nvim\x1fκαλημέρα κόσμε, τι κάνεις σήμερα')"
expected=$' Close tab 1?\n dotfiles\n\n   nvim  καλημέρα κόσμε, τι κ…\n\n y close  ·  any other key cancels'
[[ "$output" == "$expected" ]] || fail "Unexpected popup output under LC_ALL=C:"$'\n'"$output"

printf 'Close Guard action checks passed.\n'
