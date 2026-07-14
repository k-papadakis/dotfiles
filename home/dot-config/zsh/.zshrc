if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

if [[ "${OSTYPE}" == "darwin"* ]]; then
  # GNU over BSD
  path=(
    ${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin
    ${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin
    ${HOMEBREW_PREFIX}/opt/findutils/libexec/gnubin
    ${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnubin
    ${HOMEBREW_PREFIX}/opt/grep/libexec/gnubin
    ${path}
  )
  manpath=(
    ${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnuman
    ${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnuman
    ${HOMEBREW_PREFIX}/opt/findutils/libexec/gnuman
    ${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnuman
    ${HOMEBREW_PREFIX}/opt/grep/libexec/gnuman
    ${manpath}
  )
fi

path=(
  ${HOME}/.local/bin
  ${HOME}/.cargo/bin
  ${HOME}/.cabal/bin
  ${HOME}/.ghcup/bin
  ${HOMEBREW_PREFIX}/opt/rustup/bin
  ${path}
)

source "${ZDOTDIR}/opts.zsh"
source "${ZDOTDIR}/keybindings.zsh"
source "${ZDOTDIR}/completions.zsh"
source "${ZDOTDIR}/theme.zsh"
source "${ZDOTDIR}/programs.zsh"
source "${ZDOTDIR}/aliases.zsh"
source "${ZDOTDIR}/funcs.zsh"
