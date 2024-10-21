return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  keys = {
    {
      "<leader>at",
      function()
        require("copilot.suggestion").toggle_auto_trigger()
        vim.notify(
          vim.b.copilot_suggestion_auto_trigger and "Enabled Copilot Auto Trigger" or "Disabled Copilot Auto Trigger"
        )
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
