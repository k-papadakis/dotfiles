return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fd",
        function()
          require("telescope.builtin").git_files({
            cwd = "~/projects/personal/dotfiles",
          })
        end,
        desc = "Find Dotfiles",
      },
    },
    dependencies = {
      {
        "ANGkeith/telescope-terraform-doc.nvim",
        keys = {
          { "<leader>ott", ":Telescope terraform_doc<cr>", desc = "Terraform Docs All" },
          { "<leader>otm", ":Telescope terraform_doc modules<cr>", desc = "Terraform Docs Modules" },
          {
            "<leader>ota",
            ":Telescope terraform_doc full_name=hashicorp/azurerm<cr>",
            desc = "Terraform Docs Azure",
          },
          {
            "<leader>otd",
            ":Telescope terraform_doc full_name=databricks/databricks<cr>",
            desc = "Terraform Docs Databricks",
          },
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>o", group = "Open", icon = "" },
        { "<leader>ot", group = "Terraform Docs", icon = "󱁢" },
      },
    },
  },
}
