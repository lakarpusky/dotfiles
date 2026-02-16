-- ---------
-- source: https://github.com/benfrain/neovim/blob/main/lua/setup/lualine.lua
-- ----------------------------------------------------------------------------
-- Fast and easy to configure statusline
--
local u = require("utils")
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      theme = "auto",
      icons_enabled = true,
      component_separators = { "", "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {},
      globalstatus = true,
      refresh = { statusline = 1000 }, -- refresh every second for better performance
    },
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(s)
            return u.ui.mode_map[s] or s:sub(1, 1)
          end,
        },
      },
      lualine_b = {
        {
          u.ui.git_diff,
          color = nil,
          cond = function()
            return u.ui.git_diff() ~= ""
          end,
        },
      },
      lualine_c = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          draw_empty = false,
        },
        function()
          return "%="
        end,
        {
          "filetype",
          colored = true,
          icon_only = true,
          padding = { left = 0, right = 0 },
        },
        {
          "filename",
          file_status = true,
          path = 0,
          shorting_target = 40,
          padding = { left = 0 },
          color = nil,
          symbols = {
            modified = "󰐖 ",
            readonly = " ",
            unnamed = "[No Name]",
            newfile = "[New]",
          },
        },
        {
          u.ui.word_count,
          color = { fg = "#333333", bg = "#dcd7ba" },
          separator = { left = " ", right = "" },
          padding = { left = 0, right = 0 },
          cond = function()
            return u.ui.word_count() ~= ""
          end,
        },
        { "searchcount" },
        { "selectioncount" },
        {
          u.ui.macro_recording,
          color = { fg = "#333333", bg = "#ff6666" },
          separator = { left = " ", right = "" },
          padding = { left = 0, right = 0 },
          cond = function()
            return u.ui.macro_recording() ~= ""
          end,
        },
      },
      lualine_x = {
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = { fg = "#ff9e64" },
        },
        {
          u.lsp.status,
          icon = "󰐾",
          colored = true,
          color = { fg = "#76946a" },
          padding = { left = 0, right = 1 },
          cond = function()
            return u.lsp.status() ~= ""
          end,
        },
        {
          u.ui.scroll_position,
          color = { fg = "#c8c093" },
          padding = { left = 0, right = 1 },
        },
      },
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {
        { u.fn.window, color = { fg = "#26ffbb", bg = "#282828" } },
      },
      lualine_b = {
        {
          "diff",
          source = u.ui.diff_source,
          color_added = "#a7c080",
          color_modified = "#ffdf1b",
          color_removed = "#ff6666",
        },
      },
      lualine_c = {
        function()
          return "%="
        end,
        {
          "filename",
          path = 1,
          shorting_target = 40,
          symbols = {
            modified = "󰐖 ",
            readonly = " ",
            unnamed = "[No Name]",
            newfile = "[New]",
          },
        },
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = { "quickfix", "fzf" },
  },
  config = function(_, opts)
    local lualine = require("lualine")
    lualine.setup(opts)
    -- Autocommands for macro recording
    -- stylua: ignore start
    local function refresh_lualine() lualine.refresh() end
    u.fn.autocmd("RecordingEnter", { callback = refresh_lualine })
    u.fn.autocmd("RecordingLeave", { callback = function() vim.defer_fn(refresh_lualine, 50) end })
  end,
}
