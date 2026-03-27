-- =====================
-- Git integration
-- =====================
-- gitsigns, diffview, git-conflict

return {
  -- ------------
  -- source: https://github.com/lewis6991/gitsigns.nvim
  -- ---------------------------------------------------
  -- Provides fast git decorations:
  -- -------
  -- It offers signs for added, remvoed, and changed lines,
  -- asynchronous operations, navigation between hunks, preview diffs.
  --
  {
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
  },

  -- -------
  -- source: https://github.com/sindrets/diffview.nvim
  -- --------------------------------------------------
  -- To easily cycling through diffs for any git rev
  --
  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = { "DiffviewOpen", "DiffviewClose" },
    keys = {
      {
        "<leader>dv",
        function()
        -- stylua: ignore start
        if next(require("diffview.lib").views) == nil then vim.cmd("DiffviewOpen")
        else vim.cmd("DiffviewClose") end
          -- stylua: ignore end
        end,
        desc = "Git diff",
      },
    },
    config = function()
      require("diffview").setup({
        view = { file_history = { layout = "diff2_vertical" } },
        default_args = { DiffviewFileHistory = { "--max-count=100" } },
        keymaps = {
          file_panel = {
            { "n", "cc", "<Cmd>Git commit <bar> wincmd K<CR>", { desc = "Commit staged changes" } },
          },
        },
      })
    end,
  },

  -- -------
  -- source: https://github.com/akinsho/git-conflict.nvim
  -- --------------------------------------------------
  -- VSCode-like merge conflict resolution
  --
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "BufReadPre",
    config = function()
      require("git-conflict").setup({
        default_mappings = true, -- disable buffer local mapping created by this plugin
        default_commands = true, -- disable commands created by this plugin
        disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
        list_opener = "copen", -- command or function to open the conflicts list
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText",
        },
      })
    end,
  },
}
