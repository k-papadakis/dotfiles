# Source: https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/theme-and-appearance.zsh
# Sets color variables such as fg, bg, color and reset_color
autoload -U colors && colors
# Default coloring for BSD-based ls
export LSCOLORS="Gxfxcxdxbxegedabagacad"
# Default coloring for GNU-based ls
if [[ -z "${LS_COLORS}" ]]; then
  # Define LS_COLORS via dircolors if available. Otherwise, set a default
  # equivalent to LSCOLORS (generated via https://geoff.greer.fm/lscolors)
  if (($+commands[dircolors])); then
    if [[ -f "${HOME}/.dircolors" ]]; then
      source <(dircolors -b "${HOME}/.dircolors")
    else
      source <(dircolors -b)
    fi
  else
    export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
  fi
fi

if command ls --color=auto /dev/null &>/dev/null; then
  alias ls='ls --color=auto'
elif command ls -G /dev/null &>/dev/null; then
  alias ls='ls -G'
fi

if command grep --color=auto --help &>/dev/null; then
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
