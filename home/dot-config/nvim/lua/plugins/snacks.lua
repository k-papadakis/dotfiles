return {
  "folke/snacks.nvim",
  opts = {
    explorer = { replace_netrw = true },
  },
  keys = {
    {
      "<leader>fd",
      function()
        Snacks.picker.git_files({
          cwd = "~/projects/personal/dotfiles",
          finder = nil,
          format = nil,
          show_empty = nil,
        })
      end,
      desc = "Find Dotfiles",
    },
  },
}
