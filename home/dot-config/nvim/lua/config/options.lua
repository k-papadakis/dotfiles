-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.winbar = "%=%m %f"

vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.ai_cmp = false
vim.g.snacks_animate = false

vim.opt.title = true
vim.opt.titlestring = "NV | %{fnamemodify('.', ':~:t')}"

vim.opt.colorcolumn = "80"

vim.opt.langmap =
  "ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,ΡR,ΣS,ΤT,ΘU,ΩV,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz"
