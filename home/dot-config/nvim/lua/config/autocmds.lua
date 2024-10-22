-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Creating the yaml.gitlab filetype for gitlab-ci-ls and yamlls
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.gitlab-ci*.{yml,yaml}",
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

local function open_terraform_url()
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, "textDocument/hover", params, function(err, result, ctx, config)
    if err then
      print("Error: ", err)
      return
    end
    if not (result and result.contents) then
      print("No hover information available")
      return
    end
    local hover_message = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    if #hover_message < 2 then
      print("Incomplete hover information")
      return
    end

    local line1 = hover_message[1]
    local line2 = hover_message[3]

    -- Extract provider, name, and version from line1
    local resource, provider, name, version = line1:match("`[^_]*_(.+)` ([^/]+)/([^/]+) ([^ ]+)")
    if not (resource and provider and name and version) then
      print("Failed to parse line 1")
      return
    end

    -- Determine the type from line2
    local type_part = (line2 == "Data Source Type") and "data-sources"
      or (line2 == "Resource Type") and "resources"
      or nil
    if not type_part then
      print("Invalid type in line 2")
      return
    end

    -- Construct the URL
    local url = string.format(
      "https://registry.terraform.io/providers/%s/%s/%s/docs/%s/%s",
      provider,
      name,
      version,
      type_part,
      resource
    )

    -- Open the URL
    vim.ui.open(url)
  end)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "terraform",
  callback = function(event)
    vim.keymap.set("n", "<Leader>otx", open_terraform_url, { buffer = event.buf, desc = "Open in Terraform Docs" })
  end,
})
