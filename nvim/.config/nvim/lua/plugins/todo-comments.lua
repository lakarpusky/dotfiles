-- -------
-- source: https://github.com/folke/todo-comments.nvim
-- -----------------------------------------------------
-- To list and search TODO comments
--
return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup({
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = { color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { color = "info" },
        HACK = { color = "warning" },
        WARN = { color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { color = "hint", alt = { "INFO" } },
        TEST = { color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    })
  end,
  keys = {
    -- stylua: ignore start
    { "<leader>tT", function () Snacks.picker.todo_comments({ keywords = { "TODO" } }) end, desc = "Todo" },
    { "<leader>tF", function () Snacks.picker.todo_comments({ keywords = { "FIX", "FIXME" } }) end, desc = "Fix/Fixme" },
    { "<leader>tN", function () Snacks.picker.todo_comments({ keywords = { "NOTE" } }) end, desc = "Note" },

    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo" },
  },
}
