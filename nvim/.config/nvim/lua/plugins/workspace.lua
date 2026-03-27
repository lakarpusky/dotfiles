-- =====================
-- Workspace management
-- =====================
-- session restore, project root, buffer list, package.json

return {
  -- -------
  -- source: https://github.com/rmagatti/auto-session
  -- -------------------------------------------------
  -- To save and restore the workspace state easily.
  --
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" },
        auto_restore_enabled = false,
        auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
      })
      -- docs: recommended session config for the best experience
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
    keys = {
      { "<leader>ws", "<cmd>AutoSession save<cr>", desc = "Save session" },
      { "<leader>wr", "<cmd>AutoSession restore<cr>", desc = "Restore session" },
    },
  },

  -- ------
  -- source: https://github.com/airblade/vim-rooter
  -- -------------------------------------------------
  -- Changes vim working directory to app root
  --
  {
    "airblade/vim-rooter",
    event = "VeryLazy",
    config = function()
      vim.g.rooter_silent_chdir = 1
      vim.g.rooter_cd_cmd = "lcd"
      vim.g.rooter_resolve_links = 1
      vim.g.rooter_patterns = { ".git", ".git/" }
    end,
  },

  -- ------
  -- source: https://github.com/j-morano/buffer_manager.nvim
  -- --------------------------------------------------------
  -- Persistent floating buffer list on the right side
  --
  {
    "j-morano/buffer_manager.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      win_position = { h = 1.0, v = 0.5 }, -- anchored to the right, vertically centered
      width = 42,
      height = 0.85,
      short_file_names = true, -- show only filename, no path
      show_depth = false,
      order_buffers = "lastused",
      toggle_key_bindings = { "q", "<ESC>", "<leader>eb" },
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      select_menu_item_commands = {
        edit = { key = "<CR>", command = "edit" },
      },
    },
  },

  -- -------
  -- source: https://github.com/vuki656/package-info.nvim
  -- ------------------------------------------------------
  -- To manage dependencies from package.json file
  --
  {
    "vuki656/package-info.nvim",
    event = "BufEnter package.json",
    ft = "json",
    dependencies = "MunifTanjim/nui.nvim",
    opts = {
      highlights = { up_to_date = "#3C4048", outdated = "#fc514e" },
      icons = { enable = true, style = { outdated = "  ", up_to_date = "  " } },
      autostart = true, -- When `package.json` is opened
      hide_up_to_date = true,
      hide_unstable_versions = true,
      package_manager = "yarn",
    },
  },
}
