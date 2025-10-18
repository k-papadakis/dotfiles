-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Record [count]Up/Down to the jump list
map({ "n", "x" }, "j", function()
  return vim.v.count > 0 and "m'" .. vim.v.count .. "j" or "gj"
end, { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", function()
  return vim.v.count > 0 and "m'" .. vim.v.count .. "j" or "gj"
end, { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", function()
  return vim.v.count > 0 and "m'" .. vim.v.count .. "k" or "gk"
end, { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Up>", function()
  return vim.v.count > 0 and "m'" .. vim.v.count .. "k" or "gk"
end, { desc = "Down", expr = true, silent = true })

-- Escape terminal mode with 'jk'
map("t", "jk", function()
  vim.cmd("stopinsert")
end)

-- https://github.com/LazyVim/LazyVim/discussions/6587#discussioncomment-14598232
Snacks.toggle({
  name = "AI suggestions",
  get = function()
    return vim.g.sidekick_nes ~= false
  end,
  set = function(state)
    vim.g.sidekick_nes = state
    vim.lsp.inline_completion.enable(state)
  end,
}):map("<leader>aT")
