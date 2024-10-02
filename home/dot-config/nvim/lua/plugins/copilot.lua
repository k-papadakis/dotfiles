return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  keys = {
    {
      "<leader>at",
      function()
        require("copilot.suggestion").toggle_auto_trigger()
      end,
      desc = "Toggle Auto Trigger (Buffer) (Copilot)",
    },
  },
  opts = {
    panel = { enabled = false },
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
