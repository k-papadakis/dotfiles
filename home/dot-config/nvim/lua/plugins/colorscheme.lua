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
    "ellisonleao/gruvbox.nvim",
    opts = {
      dim_inactive = true,
      contrast = "", -- can be "hard", "soft" or empty string
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin",
      colorscheme = "gruvbox",
    },
  },
}
