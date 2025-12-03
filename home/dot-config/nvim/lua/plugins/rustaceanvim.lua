return {
  "mrcjkb/rustaceanvim",
  opts = {
    tools = {},
    server = {
      on_attach = function(_, bufnr)
        -- Override the <leader>cd keymap for Rust files to use renderDiagnostic
        vim.keymap.set("n", "<leader>cd", function()
          vim.cmd.RustLsp("renderDiagnostic")
        end, {
          buffer = bufnr,
          desc = "Render Diagnostic (Rust)",
        })
      end,
    },
  },
}
