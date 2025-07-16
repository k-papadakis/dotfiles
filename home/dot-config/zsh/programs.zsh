export HOMEBREW_BUNDLE_DUMP_NO_VSCODE=1
export HOMEBREW_BUNDLE_INSTALL_CLEANUP=1

export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"

# export BAT_THEME="Catppuccin Macchiato"
# export BAT_THEME="gruvbox-material-dark"
export BAT_THEME="kanagawa"

# The colors are messed up when using bat for manpages on linux.
# Nvim is great for manpaging, although a bit slow.
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export MANPAGER='nvim +Man!'
elif [[ "$OSTYPE" == "darwin"* ]]; then
  export MANPAGER="sh -c 'col -bx | bat --language=man --style=plain'"
fi

export LESS="i"
export LESSUTFCHARDEF="e000-f8ff:p,f0001-fffff:p"  # nerd font symbols

# Default Editor
if [[ -n ${SSH_CONNECTION} ]]; then
  export VISUAL=vim
else
  export VISUAL=nvim
fi
export EDITOR="${VISUAL}"

# Prevent Podman from using the OCI format
export BUILDAH_FORMAT=docker

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

eval "$(starship init zsh)"
eval "$(gh copilot alias -- zsh)"
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"

# source "${ZDOTDIR}/themes/fzf/catppuccin-macchiato.sh"
# source "${ZDOTDIR}/themes/fzf/tinted-fzf/sh/base16-gruvbox-material-dark-medium.sh"
source "${ZDOTDIR}/themes/fzf/tinted-fzf/sh/base16-kanagawa.sh"
source <(fzf --zsh)
source "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# source "${ZDOTDIR}/themes/zsh-syntax-highlighting/catppuccin/themes/catppuccin_macchiato-zsh-syntax-highlighting.zsh"
source "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
