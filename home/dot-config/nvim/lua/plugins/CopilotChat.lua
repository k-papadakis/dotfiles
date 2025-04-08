return {
  "CopilotC-Nvim/CopilotChat.nvim",
  enabled = false,
  opts = function(_, opts)
    opts.mappings = { reset = { normal = "gl" } }
  end,
}
