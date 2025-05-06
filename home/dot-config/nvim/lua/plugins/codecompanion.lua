return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanionChat Toggle" },
    { "<leader>aq", ":CodeCompanion", mode = { "n", "v" }, desc = ":CodeCompanion ([q]uickchat)" },
    { "<leader>ai", "<cmd>CodeCompanionChat Add<cr>", mode = { "n", "v" }, desc = "CodeCompanionChat Add ([i]nsert)" },
    { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanionActions ([p]rompts)" },
  },
  opts = {
    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "claude-3.7-sonnet",
            },
          },
        })
      end,
    },
    strategies = {
      chat = {
        keymaps = {
          clear = {
            modes = { n = "gl" },
          },
        },
        adapter = "copilot",
      },
    },
    display = {
      action_palette = {
        provider = "snacks",
      },
    },
  },
}
