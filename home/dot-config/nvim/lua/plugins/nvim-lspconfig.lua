return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      hyprls = {},
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
