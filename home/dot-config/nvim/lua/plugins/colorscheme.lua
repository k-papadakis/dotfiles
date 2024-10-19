return {
  {
    "catppuccin/nvim",
    opts = {
      background = {
        dark = "macchiato",
      },
      dim_inactive = {
        enabled = false,
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
      dim_inactive = false,
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
