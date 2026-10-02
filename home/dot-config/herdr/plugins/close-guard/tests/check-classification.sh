#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck disable=SC2016 # jq expression
program='include "close-guard"; busy_process($ARGS.named.agent)'

# expect <expected output> <process_info JSON> [jq args...]
expect() {
  local expected="$1" json="$2" actual
  shift 2
  actual="$(jq -r -L "$script_dir" "$@" "$program" <<<"$json")"
  if [[ "$actual" != "$expected" ]]; then
    printf 'For %s %s: expected %s, got %s.\n' "$json" "$*" "${expected:-nothing}" "${actual:-nothing}" >&2
    exit 1
  fi
}

single() {
  jq -cn --arg name "$1" '{result:{process_info:{foreground_processes:[{name:$name}]}}}'
}

for shell in zsh -bash /bin/fish ZSH; do
  expect '' "$(single "$shell")"
done
expect opencode "$(single opencode)"
expect nvim "$(single /opt/homebrew/bin/nvim)"
expect vim '{"result":{"process_info":{"foreground_processes":[{"argv0":"vim"}]}}}'

# The foreground process group leader names the pane, not its helpers.
claude='{"result":{"process_info":{"foreground_process_group_id":2,"foreground_processes":[{"name":"zsh","pid":3},{"name":"caffeinate","pid":1},{"name":"claude","pid":2}]}}}'
expect claude "$claude"
expect caffeinate '{"result":{"process_info":{"foreground_processes":[{"name":"zsh"},{"name":"caffeinate"},{"name":"claude"}]}}}'

# A foreground job that is not the shell's own is busy, even if it is a shell.
script='{"result":{"process_info":{"shell_pid":1,"foreground_process_group_id":5,"foreground_processes":[{"name":"bash","pid":5,"argv":["bash","deploy.sh"]}]}}}'
expect bash "$script"
expect deploy "$script" --arg agent deploy
expect '' '{"result":{"process_info":{"shell_pid":1,"foreground_process_group_id":1,"foreground_processes":[{"name":"zsh","pid":1}]}}}'

# A detected agent wins, but only while the pane is busy.
expect opencode "$claude" --arg agent opencode
expect '' "$(single zsh)" --arg agent opencode
expect claude "$claude" --arg agent ''

for json in '{"result":{"process_info":{"foreground_processes":[]}}}' '{"result":{}}' 'null'; do
  expect unknown "$json"
done

printf 'Close Guard classification checks passed.\n'
