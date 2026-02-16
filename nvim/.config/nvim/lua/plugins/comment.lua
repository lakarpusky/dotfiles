-- -------
-- source: https://github.com/numToStr/Comment.nvim
-- --------------------------------------------------
-- Both line and block comments, integrates with treesitter,
-- and offers varios shortcuts for quick commenting and uncommenting.
--
return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  config = function()
    require("Comment").setup({
      toggler = { line = "<leader>/", block = "<leader>?" },
      opleader = { line = "<leader>/", block = "<leader>?" },
      -- For commeting TSX, JSX, HTML files
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}
