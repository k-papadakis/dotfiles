return {
  "coder/claudecode.nvim",
  -- HACK: The terminal buffer opened by this plugin does not respect hjkl
  init = function()
    vim.api.nvim_create_autocmd("TermOpen", {
      callback = function()
        vim.keymap.set("t", "<C-h>", "<C-h>", { buffer = true, noremap = true })
        vim.keymap.set("t", "<C-j>", "<C-j>", { buffer = true, noremap = true })
        vim.keymap.set("t", "<C-k>", "<C-k>", { buffer = true, noremap = true })
        vim.keymap.set("t", "<C-l>", "<C-l>", { buffer = true, noremap = true })
      end,
    })
  end,
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { "<leader>a", nil, desc = "AI/Claude Code" },
    { "<leader>aa", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil" },
    },
    -- Diff management
    { "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
}
