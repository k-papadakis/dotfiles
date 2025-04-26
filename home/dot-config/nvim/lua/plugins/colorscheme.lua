return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      background = {
        dark = "macchiato",
      },
    },
  },
  {
    "Mofiqul/vscode.nvim",
    lazy = true,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "kanagawa",
        callback = function()
          vim.api.nvim_set_hl(0, "StatusLine", { link = "lualine_c_normal" })
        end,
      })
    end,
  },
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    init = function()
      vim.g.gruvbox_material_float_style = "dim"
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.g.gruvbox_material_diagnostic_line_highlight = 1

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {}),
        pattern = "gruvbox-material",
        callback = function()
          local config = vim.fn["gruvbox_material#get_configuration"]()
          local palette =
            vim.fn["gruvbox_material#get_palette"](config.background, config.foreground, config.colors_override)
          local set_hl = vim.fn["gruvbox_material#highlight"]
          set_hl("FlashMatch", palette.fg0, palette.bg4)
        end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
      -- colorscheme = "gruvbox-material",
    },
  },
}
