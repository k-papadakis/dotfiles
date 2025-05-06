return {
  "zbirenbaum/copilot.lua",
  opts = {
    filetypes = {
      yaml = true,
    },
    server_opts_overrides = {
      settings = {
        telemetry = {
          telemetryLevel = "off",
        },
      },
    },
  },
  init = function()
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
