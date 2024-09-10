return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local auto_select = false
    local cmp = require("cmp")
    opts.completion = {
      completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
    }
    opts.preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None
    opts.mapping["<CR>"] = LazyVim.cmp.confirm({ select = auto_select })
  end,
}
