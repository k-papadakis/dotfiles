return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Remove the datetime info
      opts.sections.lualine_z = {}
    end,
  },
}
