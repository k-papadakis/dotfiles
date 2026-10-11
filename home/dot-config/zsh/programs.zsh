export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"

export MANPAGER='nvim +Man!'

export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock

# Default Editor
export VISUAL=nvim
export EDITOR="${VISUAL}"

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"

source <(fzf --zsh)
source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
