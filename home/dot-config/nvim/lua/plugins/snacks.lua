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
      formats = {
        header = { "%s", align = "left" },
      },
      preset = {
        -- https://ascii-art.de/ascii/c/christmas.txt
        header = [[
                         .!,            .!,
                        ~ 6 ~          ~ 6 ~
                   .    ' i `  .-^-.   ' i `
                 _.|,_   | |  / .-. \   | |
                  '|`   .|_|.| (-` ) | .|_|.
                  / \ ___)_(_|__`-'__|__)_(______
                 /`,o\)_______________________o_(
                /_* ~_\[___]___[___]___[___[_[\`-.
                / o .'\[_]___[___]___[___]_[___)`-)
               /_,~' *_\_]                 [_[(  (
               /`. *  *\_]                 [___\ _\
              /   `~. o \]      ;( ( ;     [_[_]`-'
             /_ *    `~,_\    (( )( ;(;    [___]
             /   o  *  ~'\   /\ /\ /\ /\   [_[_]
            / *    .~~'  o\  ||_||_||_||   [___]
           /_,.~~'`    *  _\_||_||_||_||___[_[_]_
           /`~..  o        \:::::::::::::::::::::\
          / *   `'~..   *   \:::::::::::::::::::::\
         /_     o    ``~~.,,_\=========\_/========='
         /  *      *     ..~'\         _|_ .-_--.
        /*    o   _..~~`'*   o\           ( (_)  )
        `-.__.~'`'   *   ___.-'            `----'
              ":-------:"
                \_____/
]],
      },
    },
  },
}
