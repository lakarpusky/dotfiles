-- ---------
-- source: https://github.com/folke/trouble.nvim
-- -----------------------------------------------
-- Provides user friendly interface for displaying diagnostic,
-- references, and other information to help manage code issues effectively.
--
return {
  "folke/trouble.nvim",
  event = "VeryLazy",
  cmd = "Trouble",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    auto_open = false,
    auto_close = true,
    icons = {
      indent = require("utils.icons").trouble.indent,
      kinds = require("utils.icons").trouble.kinds,
    },
  },
  keys = {
    { "<leader>tt", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>", desc = "Trouble diagnostics" },
    { "<leader>tq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
    { "<leader>tl", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
    { "<leader>tR", "<cmd>Trouble lsp_references<cr>", desc = "Trouble lsp references" },

    -- { "<leader>tT", ":Trouble todo filter = { tag = {TODO} }<CR>", desc = "Trouble TODO" },
    -- { "<leader>tF", ":Trouble todo filter = { tag = {FIX,FIXME} }<CR>", desc = "Trouble FIX" },
    -- { "<leader>tN", ":Trouble todo filter = { tag = {NOTE} }<CR>", desc = "Trouble NOTE" },
  },
}
