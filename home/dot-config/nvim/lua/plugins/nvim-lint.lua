return {
  {
    "mfussenegger/nvim-lint",
    -- Project .markdownlint.json(c) replaces this base config, so MD013 returns there.
    opts = function(_, opts)
      local dir = vim.fn.stdpath("cache")
      local config = dir .. "/markdownlint-cli2.jsonc"
      vim.fn.mkdir(dir, "p")
      vim.fn.writefile({ vim.json.encode({ config = { MD013 = false } }) }, config)
      opts.linters = opts.linters or {}
      opts.linters["markdownlint-cli2"] = {
        prepend_args = { "--config", config },
      }
    end,
  },
}
