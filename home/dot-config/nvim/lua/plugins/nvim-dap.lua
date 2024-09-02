return {
  "mfussenegger/nvim-dap",
  optional = true,
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          -- A manual bashdb installation is also required
          "bash-debug-adapter",
        },
      },
    },
  },
}
