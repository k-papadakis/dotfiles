# Dotfiles

Configuration files.

## Instructions for MacOS

### Script

Run the following commands, and then restart your terminal. If you get any
errors about already existing files, manually back them up and remove them.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

git clone --recurse-submodules https://github.com/k-papadakis/dotfiles ~/repos/personal/dotfiles
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' \
  >>~/repos/personal/dotfiles/home/dot-config/zsh/.zprofile
brew bundle install --file \
  ~/repos/personal/dotfiles/home/dot-config/homebrew/Brewfile

mkdir ~/.config
stow --verbose --restow --target="$HOME" \
  --dir ~/repos/personal/dotfiles --dotfiles home

mkdir ~/.config/zsh/zfunc
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup completions zsh >~/.config/zsh/zfunc/_rustup
rustup completions zsh cargo >~/.config/zsh/zfunc/_cargo

gh auth login
gh extension install github/gh-copilot
```

### Alacritty

[Fix font rendering for Alacritty](https://github.com/alacritty/alacritty/issues/7333#issuecomment-2128528068)
by running

```bash
defaults write org.alacritty AppleFontSmoothing -int 0
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
[post installation instructions](https://karabiner-elements.pqrs.org/docs/manual/configuration/configure-complex-modifications/)

## Instructions for WSL

For an installation on WSL, run the following, then restart your terminal, and
then run the script of the MacOS section.

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
  ;

chsh --shell "$(which zsh)"
```
