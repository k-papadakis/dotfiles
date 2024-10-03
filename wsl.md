# Instructions for installing on WSL

Install zsh, e.g.

```bash
sudo apt update && sudo apt install zsh
```

Change the default login shell to zsh

```bash
chsh --shell $(which zsh)
```

Reopen the WSL Linux distribution. You will be prompted to configure zsh. Press
`q` to leave the menu, since we will configure it on our own.

Install wslu so that other programs can open files and links

```bash
sudo add-apt-repository ppa:wslutilities/wslu
sudo apt update
sudo apt install wslu
```

Install xclip for the clipboard to work in other programs

```bash
sudo apt install xclip
```

Install compiler stuff

```bash
sudo apt install pkg-config libssl-dev
```

Install git, e.g.

```bash
sudo add-apt-repository ppa:git-core/ppa
sudo apt update && sudo apt install git
```

Clone this repository

```bash
git clone  --recurse-submodules https://github.com/k-papadakis/dotfiles ~/repos/personal/dotfiles
```

Install homebrew. This is our main package manager from now on.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install homebrew's dependencies as the homebrew install script recommends, e.g.

```bash
sudo apt install build-essential
```

Activate homebrew with

```bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

Also, run

```bash
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/repos/personal/dotfiles/home/dot-config/zsh/.zprofile
```

Install stow

```bash
brew install stow
```

Create the `.config` directory, to avoid stowing the entire directory

```bash
mkdir ~/.config
```

Use stow

```bash
stow --verbose --restow --target=$HOME --dir ~/repos/personal/dotfiles --dotfiles home
```

Install programs

```bash
brew bundle install --file ~/.config/homebrew/Brewfile
```

Restart your shell, e.g. with

```bash
exec zsh
```

(ignore warnings about `gh copilot`)

Create a local `.gitconfig`

```bash
echo '[user]
    name = "Your User Name"
    email = "your@own.email"
[credential]
    # https://github.com/git-ecosystem/git-credential-manager/blob/main/docs/wsl.md#configuring-wsl-with-git-for-windows-recommended
    helper = "/mnt/c/Program Files/Git/mingw64/bin/git-credential-manager.exe"
' > ~/repos/personal/.gitconfig
```

Login to GitHub

```bash
gh auth login
```

Install gh copilot cli

```bash
gh extension install github/gh-copilot
```

Restart your shell.
