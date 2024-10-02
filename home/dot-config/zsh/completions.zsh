# COMPLETIONS

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
