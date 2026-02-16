-- ---------
-- source: https://github.com/nvim-treesitter/nvim-treesitter-context
-- -------------------------------------------------------------------
-- Pins the current function/class signature at the top of the screen
-- when scrolling past it, so context is never lost in large files.
--
return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    max_lines      = 3,    -- cap at 3 lines so it doesn't eat screen space
    min_window_height = 20, -- skip tiny windows (terminals, quickfix, etc.)
    line_numbers   = false, -- cleaner without line numbers in context bar
    trim_scope     = "outer",
    mode           = "cursor",
    separator      = "─",  -- visual separator between context and content
    zindex         = 20,
  },
}
