-- ------
-- source: https://github.com/folke/edgy.nvim
-- --------------------------------------------
-- To create and manage predefined window layouts
--
return {
  "folke/edgy.nvim",
  ---@module 'edgy'
  ---@param opts Edgy.Config
  opts = {
    fix_win_height = vim.fn.has("nvim-0.10.0") == 0,
    options = {
      left = { size = 40 },
      bottom = { size = 10 },
      right = { size = 40 },
      top = { size = 10 },
    },
    right = {
      {
        ft = "snacks_terminal",
        size = { width = 0.3 },
        title = "%{b:snacks_terminal.id}: %{b:term_title}",
        filter = function(_buf, win)
          return vim.w[win].snacks_win
            and vim.w[win].snacks_win.position == "right"
            and vim.w[win].snacks_win.relative == "editor"
        end,
      },
    },
    bottom = {
      {
        ft = "snacks_terminal",
        size = { height = 0.25 },
        title = "%{b:snacks_terminal.id}: %{b:term_title}",
        filter = function(_buf, win)
          return vim.w[win].snacks_win
            and vim.w[win].snacks_win.position == "bottom"
            and vim.w[win].snacks_win.relative == "editor"
            and not vim.w[win].trouble_preview
        end,
      },
      {
        ft = "Trouble",
        title = "TROUBLE",
        filter = function(buf, win)
          return vim.api.nvim_win_get_config(win).relative == ""
        end,
      },
      { ft = "qf", title = "QUICKFIX" },
      {
        ft = "noice",
        size = { height = 0.4 },
        filter = function(buf, win)
          return vim.api.nvim_win_get_config(win).relative == ""
        end,
      },
      {
        ft = "help",
        size = { height = 20 },
        -- only show help buffers
        filter = function(buf)
          return vim.bo[buf].buftype == "help"
        end,
      },
    },
  },
}
