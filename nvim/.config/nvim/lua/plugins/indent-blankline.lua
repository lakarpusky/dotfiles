-- ---------
-- source: https://github.com/lukas-reineke/indent-blankline.nvim
-- ---------------------------------------------------------------
-- Indent guides with scope highlight for deeply nested code
--
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    indent = { char = "│" },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
    },
    exclude = {
      filetypes = {
        "help", "dashboard", "neo-tree", "trouble",
        "lazy", "mason", "buffer_manager", "aerial",
      },
    },
  },
}
