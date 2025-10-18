return {
  "folke/sidekick.nvim",
  keys = {
    {
      "<c-.>",
      function()
        require("sidekick.cli").focus()
      end,
      desc = "Sidekick Focus",
      mode = { "n", "t", "i", "x" },
    },
  },
  opts = {
    cli = {
      win = {
        keys = {
          -- Disable the terminal window's <c-.> so LazyVim's focus() works everywhere
          hide_ctrl_dot = false,
          -- Disable <c-hjkl> navigation to avoid conflicts with shell keybinds
          nav_left = false,
          nav_down = false,
          nav_up = false,
          nav_right = false,
        },
      },
    },
  },
}
