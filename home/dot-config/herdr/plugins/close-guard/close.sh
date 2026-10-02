#!/usr/bin/env bash
set -euo pipefail

herdr_bin="${HERDR_BIN_PATH:-herdr}"
plugin_id="${HERDR_PLUGIN_ID:-local.close-guard}"
script_dir="${BASH_SOURCE[0]%/*}"
[[ "$script_dir" == "${BASH_SOURCE[0]}" ]] && script_dir=.
scope="${1:-}"
# Field separator for pane rows; unlike tabs, read(1) does not collapse it.
sep=$'\x1f'

# Prefer the injected env var and fall back to the plugin invocation context.
context_id() {
  local env_value="$1" key="$2"
  if [[ -n "$env_value" ]]; then
    printf '%s\n' "$env_value"
  elif [[ -n "${HERDR_PLUGIN_CONTEXT_JSON:-}" ]]; then
    jq -r --arg key "$key" '.[$key] // empty' <<<"$HERDR_PLUGIN_CONTEXT_JSON" 2>/dev/null || true
  fi
}

case "$scope" in
pane) target="$(context_id "${HERDR_PANE_ID:-}" pane_id)" ;;
tab) target="$(context_id "${HERDR_TAB_ID:-}" tab_id)" ;;
workspace) target="$(context_id "${HERDR_WORKSPACE_ID:-}" workspace_id)" ;;
*)
  printf 'Close Guard: unknown scope %q (expected pane, tab or workspace).\n' "$scope" >&2
  exit 2
  ;;
esac

if [[ -z "$target" ]]; then
  printf 'Close Guard: no %s ID was provided by Herdr.\n' "$scope" >&2
  exit 1
fi

# Starting a process is slow on machines with endpoint security, and the checks
# are serialised, so this keeps them to one snapshot, one process-info per pane
# and one jq call (two for tabs and workspaces).
jq_args=(-L "$script_dir" --arg scope "$scope" --arg target "$target" --arg sep "$sep")
snapshot="$("$herdr_bin" api snapshot 2>/dev/null)" || snapshot=''
snapshot="${snapshot:-null}"

panes=()
if [[ "$scope" == pane ]]; then
  panes=("$target")
else
  while IFS= read -r pane; do
    [[ -n "$pane" ]] && panes+=("$pane")
  done < <(jq -r "${jq_args[@]}" 'include "close-guard"; target_panes($scope; $target)[].pane_id' <<<"$snapshot" 2>/dev/null || true)
fi

infos=()
for pane in ${panes[@]+"${panes[@]}"}; do
  info="$("$herdr_bin" pane process-info --pane "$pane" 2>/dev/null)" || info=''
  infos+=("${info:-null}")
done

summary="$(printf '%s\n' "$snapshot" ${infos[@]+"${infos[@]}"} |
  jq -nr "${jq_args[@]}" --argjson n "${#infos[@]}" -f "$script_dir/summary.jq" 2>/dev/null)" ||
  summary="Close $scope?"$'\n\n'"unknown${sep}could not inspect panes"

if [[ -z "$summary" ]]; then
  "$herdr_bin" "$scope" close "$target" >/dev/null
  exit 0
fi

heading="${summary%%$'\n'*}"
summary="${summary#*$'\n'}"
context="${summary%%$'\n'*}"
rows="${summary#*$'\n'}"

"$herdr_bin" plugin pane open \
  --plugin "$plugin_id" \
  --entrypoint confirm-close \
  --env "CLOSE_GUARD_SCOPE=$scope" \
  --env "CLOSE_GUARD_TARGET=$target" \
  --env "CLOSE_GUARD_HEADING=$heading" \
  --env "CLOSE_GUARD_CONTEXT=$context" \
  --env "CLOSE_GUARD_ROWS=$rows" \
  >/dev/null
