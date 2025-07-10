return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
      {
        "ravitemer/mcphub.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        build = "npm install -g mcp-hub@latest",
        config = function()
          require("mcphub").setup()
        end,
      },
    },
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanionChat Toggle" },
      { "<leader>aq", ":CodeCompanion", mode = { "n", "v" }, desc = ":CodeCompanion ([q]uickchat)" },
      {
        "<leader>ai",
        "<cmd>CodeCompanionChat Add<cr>",
        mode = { "n", "v" },
        desc = "CodeCompanionChat Add ([i]nsert)",
      },
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanionActions ([p]rompts)" },
    },
    opts = {
      extensions = {
        history = {
          expiration_days = 14,
        },
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true, -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          },
        },
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
  },
}
