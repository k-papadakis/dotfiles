-- TODO: Add https://github.com/yetone/avante.nvim
return {
  "CopilotC-Nvim/CopilotChat.nvim",
  opts = function(_, opts)
    opts.mappings = { reset = { normal = "gl" } }
  end,
}
