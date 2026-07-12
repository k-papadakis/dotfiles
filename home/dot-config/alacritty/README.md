# Alacritty

## macOS

### Font Rendering

[Fix font rendering for Alacritty](https://github.com/alacritty/alacritty/issues/7333#issuecomment-2128528068)
by running:

```bash
defaults write org.alacritty AppleFontSmoothing -int 0
```

## Windows

### Configuration

Alacritty's configuration file is located at
`%AppData%\Roaming\alacritty\alacritty.toml`. Copy the
[Linux/macOS configuration](alacritty.toml), then update the shell for WSL:

```toml
[terminal.shell]
program = "wsl"
args = ["-d", "Ubuntu-24.04", "--cd", "~", "--", "tmux new-session -A"]
```

The configured theme must also be available locally:

```powershell
git clone https://github.com/alacritty/alacritty-theme.git "${env:APPDATA}\alacritty\alacritty-theme"
```

### Rendering Fix

Alacritty uses the default version of
[conpty.dll](https://devblogs.microsoft.com/commandline/windows-command-line-introducing-the-windows-pseudo-console-conpty/),
but Windows ships an older version that can cause rendering issues, particularly
with TMUX. Copy
[conpty.dll](https://github.com/wezterm/wezterm/blob/main/assets/windows/conhost/conpty.dll)
and
[OpenConsole.exe](https://github.com/wezterm/wezterm/blob/main/assets/windows/conhost/OpenConsole.exe)
from the [WezTerm repository](https://github.com/wezterm/wezterm/tree/main/assets/windows/conhost)
to the Alacritty installation directory, for example `C:\Program Files\Alacritty`,
as described in [this Alacritty issue](https://github.com/alacritty/alacritty/issues/1663#issuecomment-1917418514).
