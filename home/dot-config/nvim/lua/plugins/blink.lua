return {
  "saghen/blink.cmp",
  opts = {
    -- Accept with <C-y> instead of <CR>.
    keymap = {
      preset = "default",
    },
    -- `auto_brackets` does not work properly yet.
    accept = { auto_brackets = { enabled = false } },
  },
}
