return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  panel = { enabled = false },
  opts = {
    filetypes = {
      markdown = true,
      help = true,
    },
    suggestion = {
      keymap = {
        accept_word = "<M-w>",
        accept_line = "<M-l>",
        accept = "<M-y>",
      },
    },
  },
}
