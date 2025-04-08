return {
  "zbirenbaum/copilot.lua",
  opts = {
    filetypes = {
      yaml = true,
    },
  },
  config = function(_, opts)
    require("copilot").setup(opts)

    -- https://github.com/LazyVim/LazyVim/discussions/4232#discussioncomment-11191278
    require("snacks")
      .toggle({
        name = "Copilot",
        get = function()
          return not require("copilot.client").is_disabled()
        end,
        set = function(state)
          if state then
            require("copilot.command").enable()
          else
            require("copilot.command").disable()
          end
        end,
      })
      :map("<leader>aT")
  end,
}
