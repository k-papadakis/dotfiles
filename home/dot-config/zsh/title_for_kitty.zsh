# Kitty title needs to be configured from the shell, not from the terminal emulator.
# For this to take effect you need to disable the title from shell integration in kitty.conf:
# shell_integration enabled no-title
# https://github.com/kovidgoyal/kitty/discussions/7568#discussioncomment-9834803

# This is needed if oh-my-zsh is used, to prevent it from overriding the title
# DISABLE_AUTO_TITLE="true"

# Function to set terminal title
function set_terminal_title() {
  if [[ $PWD == $HOME ]]; then
    # If in the home directory, use a tilde (~) for simplicity
    local directory="~"
  else
    # Otherwise, use the current directory name
    local directory="${PWD##*/}"
  fi

  if [[ -n "$1" ]]; then
    # When a process is running, show the command and the current directory
    print -Pn "\e]0;$directory | $1\a"
  else
    # Default title showing only the current directory
    print -Pn "\e]0;$directory\a"
  fi
}

# Pre-command hook to update the terminal title before each command
function preexec() {
  # Update the terminal title with the running command and the current directory
  set_terminal_title "$1"
}

# Post-command hook to reset the terminal title after each command
function precmd() {
  # Reset the terminal title to the current directory
  set_terminal_title
}

# Call the function to set the initial title when the shell starts
set_terminal_title
