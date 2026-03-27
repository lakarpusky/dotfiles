-- =====================
-- Editor enhancements
-- =====================
-- autopairs, multi-cursor, commenting, debug printing, treesitter context

return {
  -- --------
  -- source: https://github.com/windwp/nvim-autopairs
  -- --------------------------------------------------
  -- Automatically inserts and manages paired characters like
  -- brackets and quotes as you type, enhancing coding efficiency.
  --
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local autopairs = require("nvim-autopairs")

      autopairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          javascriptreact = { "template_string" },
          typescript = { "template_string" },
          typescriptreact = { "template_string" },
          java = false,
        },
        enable_afterquote = true,
        enable_check_bracket_line = false, -- Don't add pairs if it already has a close pair
      })

      -- Integrate with blink.cmp - Hook into blink's completion events
      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpCompletionMenuOpen",
        callback = function()
          autopairs.disable()
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpCompletionMenuClose",
        callback = function()
          autopairs.enable()
        end,
      })
    end,
  },

  -- -------
  -- source: https://github.com/mg979/vim-visual-multi
  -- --------------------------------------------------
  -- vscode-like keybinds for bulk word replacing
  --
  {
    "mg979/vim-visual-multi",
    branch = "master",
    keys = { { "<C-d>", mode = { "n", "v" } } },
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
        ["Select All"] = "<C-S-l>",
        ["Skip Region"] = "<C-k><C-d>",
      }
      vim.g.VM_default_mappings = 0
    end,
  },

  -- -------
  -- source: https://github.com/windwp/nvim-ts-autotag
  -- ---------------------------------------------------
  -- Use treesitter to auto close and auto rename html tag
  --
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    },
  },

  -- -------
  -- source: https://github.com/folke/ts-comments.nvim
  -- ---------------------------------------------------
  -- Enhances Neovim's native gc/gcc commenting with proper
  -- JSX/TSX support ({/* */} vs //) via treesitter.
  -- Replaces Comment.nvim + nvim-ts-context-commentstring.
  --
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
    -- Remap <leader>/ to use native gc (now enhanced by ts-comments)
    keys = {
      { "<leader>/", "gcc", mode = "n", remap = true, desc = "Toggle comment" },
      { "<leader>/", "gc", mode = "v", remap = true, desc = "Toggle comment" },
      { "<leader>?", "gbc", mode = "n", remap = true, desc = "Toggle block comment" },
      { "<leader>?", "gb", mode = "v", remap = true, desc = "Toggle block comment" },
    },
  },

  -- -------
  -- source: https://github.com/rareitems/printer.nvim
  -- ---------------------------------------------------
  -- To add debug printing
  --
  {
    "rareitems/printer.nvim",
    event = "BufEnter",
    ft = { "lua", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    keys = { { "gp", mode = { "n", "v" } } },
    config = function()
      local formatter = function(inside, variable)
        return string.format("console.log('%s: ', %s);", inside, variable)
      end

      require("printer").setup({
        keymap = "gp",
        -- behavior = "yank",
        formatters = {
          lua = function(inside, variable)
            return string.format('print("%s: " .. %s)', inside, variable)
          end,
          javascript = formatter,
          typescript = formatter,
          javascriptreact = formatter,
          typescriptreact = formatter,
        },
        add_to_inside = function(text)
          return string.format("[L%s] %s", vim.fn.line("."), text)
        end,
      })
    end,
  },

  -- ---------
  -- source: https://github.com/nvim-treesitter/nvim-treesitter-context
  -- -------------------------------------------------------------------
  -- Pins the current function/class signature at the top of the screen
  -- when scrolling past it, so context is never lost in large files.
  --
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      max_lines = 3, -- cap at 3 lines so it doesn't eat screen space
      min_window_height = 20, -- skip tiny windows (terminals, quickfix, etc.)
      line_numbers = false, -- cleaner without line numbers in context bar
      trim_scope = "outer",
      mode = "cursor",
      separator = "─", -- visual separator between context and content
      zindex = 20,
    },
  },
}
