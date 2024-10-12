# ALIASES

# TODO: Remove this when this issue gets fixed
# https://github.com/jesseduffield/lazygit/issues/3668
alias lazygit='[[ $TERM == "tmux-256color" ]] && env TERM=screen-256color lazygit || lazygit'

alias v='nvim'
alias docker='podman'
alias cd='z'
alias ls='eza --color=auto --icons=auto'
alias tree='eza --tree --color=auto --icons=auto'
alias ll='eza --long --color=auto --icons=auto --git'
alias la='eza --long --all --color=auto --icons=auto --git'
alias lzg='lazygit'
alias lzd='lazydocker'
alias batman='bat --language=man --style=plain --paging=always'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
