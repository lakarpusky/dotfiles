-- ------------
-- source: https://github.com/lewis6991/gitsigns.nvim
-- ---------------------------------------------------
-- Provides fast git decorations:
-- -------
-- It offers signs for added, remvoed, and changed lines,
-- asynchronous operations, navigation between huncks, preview diffs.
--
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "]h", ":Gitsigns next_hunk<CR>", desc = "Next Hunk" },
    { "[h", ":Gitsigns prev_hunk<CR>", desc = "Prev Hunk" },
    { "<leader>hs", ":Gitsigns stage_hunk<CR>", desc = "Stage hunk" },
    { "<leader>hr", ":Gitsigns reset_hunk<CR>", desc = "Reset hunk" },
    { "<leader>hp", ":Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
  },
  config = function()
    require("gitsigns").setup({
      current_line_blame = true,
      current_line_blame_opts = { virt_text = true, virt_text_pos = "eol", delay = 200, ignore_whitespace = false },
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    })

    local u = require("utils")
    u.fn.sethl(0, "GitSignsCurrentLineBlame", { fg = "#444444", italic = true, blend = 10 })
  end,
}
