-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<ESC>", { silent = true })

-- Copilot toggle
-- https://github.com/LazyVim/LazyVim/discussions/4232#discussioncomment-11191278
local Snacks = require("snacks")
local copilot_exists = pcall(require, "copilot")
if copilot_exists then
  Snacks.toggle({
    name = "Copilot",
    get = function()
      return not require("copilot.client").is_disabled()
    end,
    set = function(state)
      if state then
        require("copilot.command").enable()
      else
        require("copilot.command").disable()
      end
    end,
  }):map("<leader>at")
end
