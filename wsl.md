# Instructions for installing on WSL

Install apt dependencies

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

Restart your terminal. When prompted by zsh, press `q`.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

git clone --recurse-submodules https://github.com/k-papadakis/dotfiles ~/repos/personal/dotfiles
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>~/repos/personal/dotfiles/home/dot-config/zsh/.zprofile
brew bundle install --file ~/repos/personal/dotfiles/home/dot-config/homebrew/Brewfile

mkdir ~/.config
stow --verbose --restow --target=$HOME --dir ~/repos/personal/dotfiles --dotfiles home

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

gh auth login
gh extension install github/gh-copilot
```

Restart you shell.
