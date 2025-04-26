export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

fpath+=${HOMEBREW_PREFIX}/share/zsh/site-functions
fpath+=${ZDOTDIR}/.zfunc

export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/homebrew/Brewfile"
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"
# export BAT_THEME="Catppuccin Macchiato"
# export BAT_THEME="gruvbox-material-dark"
export BAT_THEME="kanagawa"
export PATH="${PATH}:${HOME}/.local/bin"
# The colors are messed up when using bat for manpages on linux.
# Nvim is great for manpaging, although a bit slow.
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export MANPAGER='nvim +Man!'
elif [[ "$OSTYPE" == "darwin"* ]]; then
  export MANPAGER="sh -c 'col -bx | bat --language=man --style=plain'"
fi
# Prevent Podman from using the OCI format
export BUILDAH_FORMAT=docker
# Default Editor
if [[ -n ${SSH_CONNECTION} ]]; then
  export VISUAL=vim
else
  export VISUAL=nvim
fi
export EDITOR="${VISUAL}"
export LESS="-i"
HISTFILE="${ZDOTDIR}/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
# Source: https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/theme-and-appearance.zsh
# Sets color variable such as $fg, $bg, $color and $reset_color
autoload -U colors && colors
# Default coloring for BSD-based ls
export LSCOLORS="Gxfxcxdxbxegedabagacad"
# Default coloring for GNU-based ls
if [[ -z "$LS_COLORS" ]]; then
  # Define LS_COLORS via dircolors if available. Otherwise, set a default
  # equivalent to LSCOLORS (generated via https://geoff.greer.fm/lscolors)
  if (( $+commands[dircolors] )); then
    [[ -f "$HOME/.dircolors" ]] \
      && source <(dircolors -b "$HOME/.dircolors") \
      || source <(dircolors -b)
  else
    export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
  fi
fi
