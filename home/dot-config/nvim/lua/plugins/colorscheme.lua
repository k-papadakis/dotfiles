return {
  {
    "catppuccin/nvim",
    opts = {
      background = {
        dark = "mocha",
      },
      dim_inactive = {
        enabled = true,
      },
    },
  },
  {
    "RRethy/base16-nvim",
    lazy = true,
  },
  {
    "Mofiqul/vscode.nvim",
    lazy = true,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    opts = {
      dim_inactive = true,
      contrast = "", -- can be "hard", "soft" or empty string
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      -- colorscheme = "gruvbox",
    },
  },
}
