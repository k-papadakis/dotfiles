# PROGRAMS

eval "$(starship init zsh)"
eval "$(gh copilot alias -- zsh)"
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"

source "${ZDOTDIR}/themes/fzf/catppuccin-frappe.sh"
# source "${ZDOTDIR}/themes/fzf/tinted-fzf/sh/base16-gruvbox-material-dark-medium.sh"
source <(fzf --zsh)
source "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${ZDOTDIR}/themes/zsh-syntax-highlighting/catppuccin-frappe.zsh"
source "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
