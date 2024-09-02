return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      -- Prevent accepting with Enter.
      -- Usefull when `completion.autocomplete` is false.
      -- Use <C-y> instead.
      opts.mapping["<CR>"] = nil

      -- Autocomplete on demand. Use <C-Space> trigger.
      -- opts.completion.autocomplete = false
    end,
  },
}
