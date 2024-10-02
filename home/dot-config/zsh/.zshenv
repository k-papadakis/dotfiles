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
. "$HOME/.cargo/env"
