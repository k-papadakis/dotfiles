return {
  "folke/snacks.nvim",
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
  opts = {
    picker = {
      hidden = true,
      win = {
        input = {
          keys = {
            ["<c-u>"] = { mode = { "n" } },
            ["<c-d>"] = { mode = { "n" } },
          },
        },
      },
      sources = {
        files = {
          hidden = true,
        },
      },
    },
    dashboard = {
      preset = {
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
    },
  },
}
