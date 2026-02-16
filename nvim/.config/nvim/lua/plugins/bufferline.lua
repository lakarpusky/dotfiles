-- -------
-- source: https://github.com/akinsho/bufferline.nvim
-- ---------------------------------------------------
-- Similar to tabbed interfaces in GUI text editors
--
return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        mode = "tabs",
        separator_style = { "", "" }, -- thin
        diagnostic = "nvim_lsp",
        indicator = { style = "icon" },

        -- stylua: ignore start
        close_command = function(n) Snacks.bufdelete(n) end,
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
        numbers = function(opts) return string.format("%s", opts.ordinal) end,

        -- Filter out filetypes I don't want to see
        custom_filter = function(buf_number)
          if vim.bo[buf_number].filetype ~= "qf" then
            return true
          end
        end,

        show_close_icon = false,
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        style_preset = bufferline.style_preset.no_italic,
        offsets = {
          {
            text = "",
            filetype = "snacks_layout_box",
            highlight = "NeoTreeTitle",
            text_align = "center",
            separator = false,
          },
        },
      },
    })
  end,
}
