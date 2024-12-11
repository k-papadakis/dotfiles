# COMPLETIONS

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

complete -o nospace -C terraform terraform
source "${HOMEBREW_PREFIX}/etc/bash_completion.d/az"
