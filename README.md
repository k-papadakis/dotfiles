# Dotfiles

Configuration files.

## Homebrew

Install [homebrew](https://brew.sh/)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Most of the programs that are used or referenced by the configuration files,
as well as other useful programs, can be installed by running

```bash
brew bundle install
```

## iTerm2

Open iTerm2, import [iterm2/myprofile.json](/iterm2/myprofile.json), and select it as

## Symlinking

Manually back up and remove already existing configuration files,
and then create symbolic links with [stow](https://www.gnu.org/software/stow/).

```bash
stow --verbose --restow --target=$HOME --dotfiles home
```

## Programs installation

### [ohmyzsh](https://ohmyz.sh/#install)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### ohmyzsh plugins

Zsh Syntax Highlighting

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Zsh Autosuggestions

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Zsh Vi Mode

```bash
git clone https://github.com/jeffreytse/zsh-vi-mode \
  $ZSH_CUSTOM/plugins/zsh-vi-mode
```

### Additional installations

- [GitHub Copilot CLI](https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-in-the-command-line)
- [Rust](https://www.rust-lang.org/tools/install)

- [Haskell](https://www.haskell.org/ghcup/)

- [Podman](https://podman.io/docs/installation)

### Next steps

Create autocompletions for each program, according to each programs instructions.
