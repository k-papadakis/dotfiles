return {
  "coder/claudecode.nvim",
  init = function()
    -- Preserve terminal navigation keys in Claude Code terminals
    -- Prevents C-hjkl from being intercepted for window navigation
    local group = vim.api.nvim_create_augroup("ClaudeCodeTerminal", { clear = true })
    vim.api.nvim_create_autocmd("TermOpen", {
      group = group,
      callback = function(ev)
        local bufname = vim.api.nvim_buf_get_name(ev.buf)
        if bufname:match(":claude$") then
          vim.keymap.set("t", "<C-h>", "<C-h>", { buffer = ev.buf, noremap = true })
          vim.keymap.set("t", "<C-j>", "<C-j>", { buffer = ev.buf, noremap = true })
          vim.keymap.set("t", "<C-k>", "<C-k>", { buffer = ev.buf, noremap = true })
          vim.keymap.set("t", "<C-l>", "<C-l>", { buffer = ev.buf, noremap = true })
        end
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
