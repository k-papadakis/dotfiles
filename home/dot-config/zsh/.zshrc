if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Unsupported OS: $OSTYPE"
  exit 1
fi

source ${ZDOTDIR}/opts.zsh
source ${ZDOTDIR}/keybindings.zsh
source ${ZDOTDIR}/completions.zsh
source ${ZDOTDIR}/programs.zsh
source ${ZDOTDIR}/aliases.zsh
source ${ZDOTDIR}/funcs.zsh
