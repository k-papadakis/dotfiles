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

-- <leader>= as an alternative to <leader>| because it is easier to type
map("n", "<leader>=", "<C-W>v", { desc = "Split Window Right", remap = true })

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

-- Greek Remaps
-- stylua: ignore start
local layout_mappings = {
  { "α", "a" }, { "β", "b" }, { "ψ", "c" }, { "δ", "d" }, { "ε", "e" },
  { "φ", "f" }, { "γ", "g" }, { "η", "h" }, { "ι", "i" }, { "ξ", "j" },
  { "κ", "k" }, { "λ", "l" }, { "μ", "m" }, { "ν", "n" }, { "ο", "o" },
  { "π", "p" }, { "ρ", "r" }, { "σ", "s" }, { "τ", "t" }, { "θ", "u" },
  { "ω", "v" }, { "ς", "w" }, { "χ", "x" }, { "υ", "y" }, { "ζ", "z" },
}
-- stylua: ignore end
for _, mapping in ipairs(layout_mappings) do
  local gr, en = mapping[1], mapping[2]
  local gr_key = string.format("<C-%s>", gr)
  local en_key = string.format("<C-%s>", en)
  local modes = (en == "i") and { "n", "x", "s", "c" } or { "n", "i", "x", "s", "c" }
  vim.keymap.set(modes, gr_key, en_key, {
    noremap = true,
    silent = true,
    desc = string.format("Greek Ctrl-%s fix", en),
  })
end
vim.keymap.set({ "i", "x", "n", "s" }, "<C-σ>", "<cmd>w<cr><esc>", { desc = "Save File" })
