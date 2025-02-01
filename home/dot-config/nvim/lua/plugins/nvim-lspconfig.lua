return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      bashls = {},
      gitlab_ci_ls = {},
      yamlls = {
        settings = {
          yaml = {
            customTags = { "!reference sequence" }, -- gitlab syntax
          },
        },
      },
      jqls = {},
    },
  },
}
