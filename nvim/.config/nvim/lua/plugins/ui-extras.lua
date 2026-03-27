-- =====================
-- UI extras
-- =====================
-- illuminate, colorizer, rainbow delimiters, todo comments

return {
  -- ---------
  -- source: https://github.com/RRethy/vim-illuminate
  -- --------------------------------------------------
  -- Highlights all occurrences of the word under the cursor
  --
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      delay = 200,
      providers = { "lsp", "treesitter" },
      large_file_cutoff = 2000,
      large_file_overrides = { providers = { "lsp" } },
      filetypes_denylist = {
        "neo-tree",
        "dashboard",
        "lazy",
        "mason",
        "trouble",
        "buffer_manager",
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  -- --------
  -- source: https://github.com/catgoose/nvim-colorizer.lua
  -- --------------------------------------------------------
  -- Color highlighting of CSS and other file types.
  --
  {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        filetypes = {
          "css",
          "scss",
          "html",
          "javascript",
          "typescript",
          "typescriptreact",
          "javascriptreact",
          "lua",
        },
        buftypes = { "!prompt", "!popup" }, -- Disable for large files
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = false,
          rgb_fn = true,
          css = true,
          css_fn = true,
          mode = "virtualtext",
          virtualtext = "",
        },
      })
    end,
  },

  -- -------
  -- source: https://github.com/hiphish/rainbow-delimiters.nvim
  -- ------------------------------------------------------------
  -- Rainbow delimiters with Tree-sitter
  --
  {
    "hiphish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    submodules = false, -- Skip test submodule
    config = function()
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = require("rainbow-delimiters").strategy["global"],
          jsx = require("rainbow-delimiters").strategy["noop"],
          tsx = require("rainbow-delimiters").strategy["noop"],
          html = require("rainbow-delimiters").strategy["noop"],
        },
        query = {
          [""] = "rainbow-delimiters",
          jsx = "rainbow-parens",
          tsx = "rainbow-parens",
        },
      })
    end,
  },

  -- -------
  -- source: https://github.com/folke/todo-comments.nvim
  -- -----------------------------------------------------
  -- To list and search TODO comments
  --
  {
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
  },
}
