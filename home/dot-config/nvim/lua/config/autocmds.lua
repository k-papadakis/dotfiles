-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Creating the yaml.gitlab filetype for gitlab-ci-ls and yamlls
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.gitlab-ci*.{yml,yaml}", "*/devops/*.{yml,yaml}" },
  callback = function()
    vim.bo.filetype = "yaml.gitlab"
  end,
})

-- *.tftpl files as hcl files.
-- It is not great, but it is better than nothing.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tftpl",
  callback = function()
    vim.bo.filetype = "hcl"
  end,
})

-- Open Terraform documentation URLs
vim.api.nvim_create_autocmd("LspAttach", {
  pattern = "*.tf",
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.name == "terraformls" then
      vim.keymap.set("n", "<Leader>cx", function()
        local params = vim.lsp.util.make_position_params()
        vim.lsp.buf_request(0, "textDocument/hover", params, function(err, result)
          if err or not result.contents then
            return
          end
          local hover_message = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
          local type = (hover_message[3] == "Data Source Type") and "data-sources"
            or (hover_message[3] == "Resource Type") and "resources"
          local resource, provider, name, version = hover_message[1]:match("`[^_]*_(.+)` ([^/]+)/([^/]+) ([^ ]+)")
          if not (type and resource and provider and name and version) then
            return
          end
          local url_template = "https://registry.terraform.io/providers/%s/%s/%s/docs/%s/%s"
          local url = string.format(url_template, provider, name, version, type, resource)
          vim.ui.open(url)
        end)
      end, { buffer = event.buf, desc = "Open in Terraform Docs" })
    end
  end,
})
