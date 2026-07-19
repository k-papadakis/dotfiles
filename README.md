# Dotfiles

Configuration files.

## Instructions for MacOS

### Script

Run the following commands, and then restart your terminal (press `q` when
prompted by zsh). If you get any errors about already existing files, manually
back them up and remove them.

```bash
git clone --recurse-submodules https://github.com/k-papadakis/dotfiles ~/projects/personal/dotfiles

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
brew bundle install --file \
  ~/projects/personal/dotfiles/home/dot-config/homebrew/Brewfile

mkdir ~/.config
stow --verbose --restow --target="$HOME" \
  --dir ~/projects/personal/dotfiles --dotfiles home
```

### PAM

Enable touch id authentication for `sudo`, including from within TMUX, by
running

```bash
sudo echo \
"auth       optional       $(brew --prefix)/lib/pam/pam_reattach.so       ignore_ssh
auth       sufficient     pam_tid.so" > /etc/pam.d/sudo_local
```

### Karabiner

To give the required privileges to Karabiner, follow the
[post installation instructions](https://karabiner-elements.pqrs.org/docs/getting-started/installation/#open-karabiner-elements-settings)

## Instructions for WSL

### WSL Script

For an installation on WSL, run the following, then restart your terminal, and
then run the [Script](#script) of the MacOS section.

```bash
sudo add-apt-repository ppa:wslutilities/wslu
sudo add-apt-repository ppa:git-core/ppa
sudo apt update -y
sudo apt install -y \
  zsh \
  wslu \
  xclip \
  pkg-config \
  libssl-dev \
  git \
  build-essential \
  direnv \
  ;

chsh --shell "$(which zsh)"
```
