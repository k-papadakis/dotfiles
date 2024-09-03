return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      bashls = {},
      -- FIXME: gitlab_ci_ls is supposed to have more functionality, like gd
      gitlab_ci_ls = {},
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              -- Databricks Asset Bundles schema. To activate it, run
              -- `databricks bundle schema > .bundle_config_schema.json`
              -- in a Databricks Asset Bundles project
              ["./.bundle_config_schema.json"] = { "databricks.yml", "databricks/**/*.{yml,yaml}" },
            },
          },
        },
      },
    },
  },
}
