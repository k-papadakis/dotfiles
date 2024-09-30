# KEYBINDINGS
# Because, $EDITOR contains "vi", zsh automatically sets `bindkey -v`
# Revert it back to emacs keybindings.
bindkey -e
# ^X^E to open the current command line in $EDITOR, like in bash.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# AUTOCOMPLETIONS
unsetopt LIST_BEEP
setopt CORRECT_ALL
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

fpath+=${HOMEBREW_PREFIX}/share/zsh/site-functions
fpath+=${ZDOTDIR}/.zfunc
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

complete -o nospace -C terraform terraform
source "${HOMEBREW_PREFIX}/etc/bash_completion.d/az"

# PROGRAMS SETUP
eval "$(starship init zsh)"
eval "$(gh copilot alias -- zsh)"
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"

source "${ZDOTDIR}/fzf/themes/catppuccin-mocha.zsh"
source <(fzf --zsh)
source "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${ZDOTDIR}/zsh-syntax-highlighting/themes/catppuccin-mocha.zsh"
source "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# ALIASES
alias docker="podman"
alias cd="z"
alias ls="eza --color=auto --icons=auto"
alias tree="eza --tree --color=auto --icons=auto"
alias ll="eza --long --color=auto --icons=auto --git"
alias la="eza --long --all --color=auto --icons=auto --git"
alias lzg="lazygit"
alias lzd="lazydocker"
alias batman="bat --language=man --style=plain --paging=always"
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
