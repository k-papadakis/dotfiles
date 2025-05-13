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

bat cache --build

mkdir ~/.config/zsh/zfunc
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup completions zsh >~/.config/zsh/.zfunc/_rustup
rustup completions zsh cargo >~/.config/zsh/.zfunc/_cargo

gh auth login
gh extension install github/gh-copilot
```

### Alacritty fix on MacOS

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

### Alacritty on Windows

Alacritty is a popular cross-platform terminal that noticeably faster when
compared to Windows Terminal.

#### Configuration

Alacritty's config on Windows is located at
`%AppData%\Roaming\alacritty\alacritty.toml`.

You can copy the
[configuration for linux/mac](home/dot-config/alacritty/alacritty.toml) and
modify the `terminal.shell` part with something like

```toml
[terminal.shell]
program = "wsl"
args = ["-d", "Ubuntu-24.04", "--cd", "~", "--", "tmux new-session -A"]
```

Imported files (e.g. themes)

```toml
[general]
import = ["./alacritty-theme/themes/kanagawa_wave.toml"]
```

need to be available locally, e.g. by running

```powershell
git clone https://github.com/alacritty/alacritty-theme.git "${env:APPDATA}\alacritty\alacritty-theme"
```

#### Rendering Fix

Alacritty uses the default version of
[conpty.dll](https://devblogs.microsoft.com/commandline/windows-command-line-introducing-the-windows-pseudo-console-conpty/)
but Windows is shipped with an older version of it. This causes various
rendering issues, particularly when using TMUX. To fix these issues you can copy
the
[conpty.dll](https://github.com/wezterm/wezterm/blob/main/assets/windows/conhost/conpty.dll)
and
[OpenConsole.exe](https://github.com/wezterm/wezterm/blob/main/assets/windows/conhost/OpenConsole.exe)
artifacts from the
[WezTerm repository](https://github.com/wezterm/wezterm/tree/main/assets/windows/conhost)
to the Alacritty installation directory (e.g. `C:\Program Files\Alacritty`), as
pointed out in this
[Github issue](https://github.com/alacritty/alacritty/issues/1663#issuecomment-1917418514).
