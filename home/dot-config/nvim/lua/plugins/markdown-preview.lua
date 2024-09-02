-- to fix this issue
--   https://github.com/iamcco/markdown-preview.nvim/issues/695
return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && yarn install",
}
