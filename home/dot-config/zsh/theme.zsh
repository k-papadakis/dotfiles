export DOTFILES_THEME="kanagawa"

case "${DOTFILES_THEME:-}" in
kanagawa)
  export NVIM_COLORSCHEME="kanagawa-wave"
  export BAT_THEME="kanagawa"
  source "${ZDOTDIR}/themes/fzf/kanagawa/kanagawa-wave.sh"
  ;;
tokyonight)
  export NVIM_COLORSCHEME="tokyonight-night"
  export BAT_THEME="tokyonight_night"
  source "${ZDOTDIR}/themes/fzf/tokyonight/tokyonight_night.sh"
  ;;
catppuccin)
  export NVIM_COLORSCHEME="catppuccin-macchiato"
  export BAT_THEME="Catppuccin Macchiato"
  source "${ZDOTDIR}/themes/fzf/catppuccin/catppuccin-macchiato.sh"
  source "${ZDOTDIR}/themes/zsh-syntax-highlighting/catppuccin/themes/catppuccin_macchiato-zsh-syntax-highlighting.zsh"
  ;;
gruvbox-material)
  export NVIM_COLORSCHEME="gruvbox-material"
  export BAT_THEME="gruvbox-material-dark"
  source "${ZDOTDIR}/themes/fzf/gruvbox-material/gruvbox-material-dark-medium.sh"
  ;;
vscode)
  export NVIM_COLORSCHEME="vscode"
  export BAT_THEME="Visual Studio Dark+"
  source "${ZDOTDIR}/themes/fzf/vscode/vscode-dark.sh"
  ;;
"") ;;
*)
  echo "Unknown DOTFILES_THEME: ${DOTFILES_THEME}" >&2
  ;;
esac
