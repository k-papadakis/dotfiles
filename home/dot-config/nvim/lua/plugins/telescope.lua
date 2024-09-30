return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>fd",
      function()
        require("telescope.builtin").git_files({
          cwd = "~/repos/personal/dotfiles",
          git_command = { "git", "ls-files", "--exclude-standard", "--cached" },
        })
      end,
      desc = "Find Dotfiles",
    },
  },
}
