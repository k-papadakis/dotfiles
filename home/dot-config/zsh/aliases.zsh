# HACK: if brew self updates then it fails to discover the Brewfile, so we run it again
alias bb='brew bundle --global || brew bundle --global'

# TODO: Remove this when a relevant config option is introduced
# See also https://github.com/github/copilot-cli/issues/30
alias copilot='copilot --disable-mcp-server github-mcp-server'

alias ur='uv run'
alias cr='cargo run'
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
alias pip='uv pip'
alias pipx='uv tool'
alias icat='kitten icat'
alias dab='databricks bundle'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
