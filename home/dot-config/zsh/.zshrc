if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

source ${ZDOTDIR}/opts.zsh
source ${ZDOTDIR}/keybindings.zsh
source ${ZDOTDIR}/completions.zsh
source ${ZDOTDIR}/programs.zsh
source ${ZDOTDIR}/aliases.zsh
source ${ZDOTDIR}/funcs.zsh
