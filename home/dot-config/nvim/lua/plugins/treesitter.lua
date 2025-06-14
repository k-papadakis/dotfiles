return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "jq",
        "css",
        "latex",
        "norg",
        "scss",
        "svelte",
        "typst",
        "vue",
      })
    end,
  },
}
