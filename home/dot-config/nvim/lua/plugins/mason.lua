return {
  {
    "mason.nvim",
    opts = { ensure_installed = { "shellcheck", "shfmt" } },
  },

  -- TODO: unpin when LazyVim gets up to date
  -- https://github.com/LazyVim/LazyVim/issues/6039
  { "mason.nvim", version = "^1.0.0" },
  { "mason-lspconfig.nvim", version = "^1.0.0" },
}
