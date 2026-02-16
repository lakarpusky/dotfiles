-- ------
-- source: https://github.com/j-morano/buffer_manager.nvim
-- --------------------------------------------------------
-- Persistent floating buffer list on the right side
--
return {
  "j-morano/buffer_manager.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    win_position  = { h = 1.0, v = 0.5 }, -- anchored to the right, vertically centered
    width         = 42,
    height        = 0.85,
    short_file_names = true,               -- show only filename, no path
    show_depth    = false,
    order_buffers = "lastused",
    toggle_key_bindings = { "q", "<ESC>", "<leader>eb" },
    borderchars   = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    select_menu_item_commands = {
      edit = { key = "<CR>", command = "edit" },
    },
  },
}
