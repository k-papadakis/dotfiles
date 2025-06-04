export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

export PATH="${PATH}:${HOME}/.local/bin:${HOME}/.cargo/bin"

fpath+=${ZDOTDIR}/.zfunc

source ${ZDOTDIR}/opts.zsh
source ${ZDOTDIR}/keybindings.zsh
source ${ZDOTDIR}/completions.zsh
source ${ZDOTDIR}/programs.zsh
source ${ZDOTDIR}/aliases.zsh
source ${ZDOTDIR}/funcs.zsh
