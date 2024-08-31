return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      -- Prevent accepting with Enter. Usefull when `completion.autocomplete` is false.
      -- opts.mapping["<CR>"] = nil

      -- Autocomplete on demand (use <c-N> or <c-P> to trigger).
      opts.completion.autocomplete = false
    end,
  },
}
