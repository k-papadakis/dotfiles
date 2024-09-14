-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Remove LazyVim's Prev/Next Buffer with H and L,
-- because they override vim defaults.
-- Just use [b and ]b.
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")
