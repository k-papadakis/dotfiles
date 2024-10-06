return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>fd",
      function()
        require("telescope.builtin").git_files({
          cwd = "~/repos/personal/dotfiles",
        })
      end,
      desc = "Find Dotfiles",
    },
  },
}
