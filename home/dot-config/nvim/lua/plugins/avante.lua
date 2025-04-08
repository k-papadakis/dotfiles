return {
  "yetone/avante.nvim",
  enabled = false,
  event = "VeryLazy",
  version = false,
  opts = {
    provider = "copilot",
    file_selector = { provider = "snacks" },
  },
  build = "make",
  keys = {
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts_extend = { "filetypes" },
      opts = {
        file_types = { "Avante" },
      },
      ft = { "Avante" },
    },
    {
      "saghen/blink.cmp",
      dependencies = { "Kaiser-Yang/blink-cmp-avante" },
      opts = {
        sources = {
          default = { "avante" },
          providers = {
            avante = {
              module = "blink-cmp-avante",
              name = "Avante",
              opts = {},
            },
          },
        },
      },
    },
  },
}
