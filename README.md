# Dotfiles

Configuration files.

## Homebrew

Install [homebrew](https://brew.sh/)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## [OhMyZsh](https://ohmyz.sh/#install)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## OhMyZsh plugins

Zsh Syntax Highlighting

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Zsh Autosuggestions

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

## Symlinking

Install [stow](https://www.gnu.org/software/stow/) with

```bash
brew install stow
```

Create symbolic links with `stow`.

```bash
stow --verbose --restow --target=$HOME --dotfiles home
```

If you get any errors about already existing files,
manually back them up and remove them.

## Homebrew Bundle

Most of the programs that are used or referenced by the configuration files,
as well as other useful programs, can be installed by running

```bash
brew bundle install
```

## iTerm2

- Open [iterm2/myprofile.json](/iterm2/myprofile.json) and
  edit the `Working Directory` field to your home directory.
- Open iTerm2, import [iterm2/myprofile.json](/iterm2/myprofile.json),
  and select it as the default.

## Additional installations

- [GitHub Copilot CLI](https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-in-the-command-line)

- [Rust](https://www.rust-lang.org/tools/install)

- [Haskell](https://www.haskell.org/ghcup/)

- [Podman](https://podman.io/docs/installation)

- [Yarn](https://classic.yarnpkg.com/lang/en/docs/install/)

### Next steps

#### Autocompletions

Create autocompletions for each program, according to each programs instructions.

#### PAM

Enable touch id authentication for `sudo`, including from within tmux,
by running

```bash
sudo echo \
"auth       optional       $(brew --prefix)/lib/pam/pam_reattach.so       ignore_ssh
auth       sufficient     pam_tid.so" > /etc/pam.d/sudo_local
```

#### Karabiner

To give the required privileges to Karabiner,
follow the
[post installation instructions](https://karabiner-elements.pqrs.org/docs/manual/configuration/configure-complex-modifications/)
.
