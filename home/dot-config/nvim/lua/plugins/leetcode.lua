return {
  "kawre/leetcode.nvim",
  lazy = vim.fn.argv(0) ~= "leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    lang = "python3",
  },
}
