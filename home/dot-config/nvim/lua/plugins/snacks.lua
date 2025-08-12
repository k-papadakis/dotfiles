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
    terminal = {
      win = {
        keys = {
          -- Remove terminal mode remaps
          nav_h = false,
          nav_j = false,
          nav_k = false,
          nav_l = false,
        },
      },
    },
    styles = {
      terminal = {
        keys = {
          -- Remove double Escape terminal mapping, use jk instead
          term_normal = false,
        },
      },
    },
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
