export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/homebrew/Brewfile"
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"
# export BAT_THEME="Catppuccin Mocha"
export BAT_THEME="gruvbox-dark"
export PATH="${PATH}:${HOME}/.local/bin"
# Use bat for man pages
export MANPAGER="sh -c 'col -bx | bat --language=man --style=plain'"
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
export TINTED_TMUX_OPTION_STATUSBAR=1

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
