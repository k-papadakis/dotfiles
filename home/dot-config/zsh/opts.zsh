[ -d "$XDG_STATE_HOME"/zsh ] || mkdir -p "$XDG_STATE_HOME"/zsh

HISTFILE="$XDG_STATE_HOME"/zsh/history
HISTSIZE=50000
SAVEHIST=10000

# Disable Apple's "save/restore shell state" feature.
SHELL_SESSIONS_DISABLE=1

unsetopt LIST_BEEP
setopt INTERACTIVE_COMMENTS

# History command configuration
setopt EXTENDED_HISTORY       # record timestamp of command in HISTFILE
setopt HIST_EXPIRE_DUPS_FIRST # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_DUPS       # ignore duplicated commands history list
setopt HIST_IGNORE_SPACE      # ignore commands that start with space
setopt HIST_VERIFY            # show command with history expansion to user before running it
setopt SHARE_HISTORY          # share command history data
