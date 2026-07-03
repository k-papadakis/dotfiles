-- Uses https://github.com/mrcjkb/haskell-tools.nvim instead of bare `hls` via
-- nvim-lspconfig, for auto-refreshing codeLenses, a GHCi repl, Hoogle search,
-- project-aware root-dir detection, and DAP auto-discovery.
--
-- haskell-language-server is intentionally NOT mason-installed: mason-lspconfig
-- would auto-start a second, conflicting `hls` client as soon as the binary is
-- present. Install/upgrade it with `ghcup install hls`.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "haskell" })
    end,
  },
  {
    "mrcjkb/haskell-tools.nvim",
    -- Implements its own lazy-loading via ftplugin (see :h lua-plugin-lazy).
    lazy = false,
    -- Needed to register the `<leader>ch` group name/icon below.
    dependencies = { "folke/which-key.nvim" },
    -- Must use `init`, not `config`/`opts`: this has to be set before
    -- haskell-tools.nvim's own ftplugin fires, and `init` is the only hook
    -- lazy.nvim guarantees runs before any plugin is added to rtp.
    init = function()
      vim.g.haskell_tools = {
        hls = {
          on_attach = function(_, bufnr, ht)
            require("which-key").add({
              mode = "n",
              buffer = bufnr,
              { "<leader>ch", group = "haskell", icon = { cat = "filetype", name = "haskell" } },
            })
            local opts = { buffer = bufnr, silent = true }
            local function map(lhs, rhs, desc)
              vim.keymap.set("n", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
            end
            map("<leader>chs", ht.hoogle.hoogle_signature, "Hoogle Signature Search")
            map("<leader>che", ht.lsp.buf_eval_all, "Eval All Code Snippets")
            map("<leader>chR", ht.repl.toggle, "Toggle Repl (Package)")
            map("<leader>chr", function()
              ht.repl.toggle(vim.api.nvim_buf_get_name(0))
            end, "Toggle Repl (Buffer)")
            map("<leader>chq", ht.repl.quit, "Quit Repl")
          end,
        },
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "haskell-debug-adapter" } },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      { "mrcjkb/neotest-haskell" },
    },
    opts = {
      adapters = {
        ["neotest-haskell"] = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        haskell = { "fourmolu" },
        cabal = { "cabal_fmt" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        haskell = { "hlint" },
      },
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "hlint" } },
      },
    },
  },
}
