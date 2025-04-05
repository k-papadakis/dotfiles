# KEYBINDINGS

# When $EDITOR contains "vi", zsh automatically sets `bindkey -v`
# Revert it back to emacs keybindings.
bindkey -e

# ^X^E to open the current command line in $EDITOR, like in bash.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

bindkey "^[[3~" delete-char
