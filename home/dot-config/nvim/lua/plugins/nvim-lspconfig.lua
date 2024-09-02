return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      bashls = {},
      -- FIXME: gitlab_ci_ls is supposed to have more functionality, like gd
      gitlab_ci_ls = {},
    },
  },
}
