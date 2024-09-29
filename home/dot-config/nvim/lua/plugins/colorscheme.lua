return {
  {
    "catppuccin/nvim",
    opts = {
      transparent_background = false,
      background = {
        light = "latte",
        dark = "mocha",
      },
      dim_inactive = {
        enabled = true,
      },
    },
  },
  { "RRethy/base16-nvim" },
  { "Mofiqul/vscode.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
