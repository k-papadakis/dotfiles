export HOMEBREW_BUNDLE_DUMP_NO_VSCODE=1
export HOMEBREW_BUNDLE_FORCE_INSTALL_CLEANUP=1

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"

export MANPAGER='nvim +Man!'

# Default Editor
if [[ -n ${SSH_CONNECTION} ]]; then
  export VISUAL=vim
else
  export VISUAL=nvim
fi
export EDITOR="${VISUAL}"

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"

source <(fzf --zsh)
source "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
