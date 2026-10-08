# Herdr Close Guard

This local Herdr plugin mirrors Kitty's `close_window_with_confirmation
ignore-shell` and `confirm_os_window_close -1` behavior for panes, tabs and
workspaces:

- Every affected pane is a shell sitting at its prompt: close immediately.
- Any non-shell process, a shell running something (a script, `sh -c`, a
  nested shell), missing or inconsistent process information, or panes missing
  from Herdr's snapshot: ask in a modal popup. Only `y` closes; all other keys
  cancel.

It uses Herdr's `api snapshot` and `pane process-info` APIs and fails closed when
process classification is uncertain. Since Herdr plugins only run for their
bound keys and menu contexts, this does not intercept CLI/API close requests or
panes exiting on their own. Only the foreground is checked, so a background job
(`cmd &`) behind an idle prompt is closed without asking.

## Setup

The plugin is linked locally from this dotfiles checkout; it has no external
runtime dependencies beyond Bash, `jq`, and Herdr. The link is kept in the
untracked `plugins.json`, so run this once per machine (and again after
changing `herdr-plugin.toml`):

```sh
herdr plugin link ~/.config/herdr/plugins/close-guard
```

`config.toml` binds the plugin's actions over the built-in close keys:

| Key              | Action            |
| ---------------- | ----------------- |
| `prefix+x`       | `close-pane`      |
| `prefix+shift+x` | `close-tab`       |
| `prefix+shift+d` | `close-workspace` |

## Tests

```sh
bash tests/check-classification.sh
bash tests/check-actions.sh
```
