[ -d "${XDG_CACHE_HOME}/zsh" ] || mkdir -p "${XDG_CACHE_HOME}/zsh"
[ -d "${ZDOTDIR}/completions" ] || mkdir -p "${ZDOTDIR}/completions"

fpath=(
  ${ZDOTDIR}/completions
  ${fpath}
)

zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/zcompcache"
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

autoload -Uz compinit && compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"
