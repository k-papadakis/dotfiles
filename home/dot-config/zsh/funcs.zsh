fpath=(
  "${ZDOTDIR}/functions"
  "${fpath[@]}"
)

# Use `autoload -U` to avoid expanding aliases
autoload mkcd y c copilot-quota claude-quota
