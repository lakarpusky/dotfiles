-- --------
-- source: https://github.com/Saghen/blink.cmp
-- ---------------------------------------------
-- Completion plugin that supports features like:
-- LSP, command line completion and snippeet.
-- -----------
-- Offers extensibility throught plugable sources
--
return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = {
    "rafamadriz/friendly-snippets",
    "mikavilpas/blink-ripgrep.nvim",
    "xzbdmw/colorful-menu.nvim",
  },
  version = "1.*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "super-tab" },
    completion = {
      -- Only match from the start of words (not middle), improves relevance
      keyword = { range = "prefix" },
      list = {
        selection = {
          preselect = true,
          -- Don't auto-insert on selection, wait for explicit confirm (better control)
          auto_insert = false,
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = "single" },
      },
      trigger = {
        show_on_trigger_character = true,
        show_on_insert_on_trigger_character = true,
        show_on_accept_on_trigger_character = true,
      },
      menu = {
        border = "single",
        max_height = 15,
        draw = {
          padding = 0,
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = require("colorful-menu").blink_components_text,
              highlight = require("colorful-menu").blink_components_highlight,
            },
            kind_icon = {
              text = function(ctx)
                local icons = require("utils.icons").blink.kinds
                return icons[ctx.kind] or ""
              end,
            },
          },
          -- stylua: ignore start
          -- components = {
          --   kind = { text = function(ctx) return " " .. ctx.kind .. " " end },
          --   kind_icon = {
          --     text = function(ctx) return " " .. ctx.kind_icon .. " " end,
          --     highlight = function(ctx) return "BlinkCmpKindIcon" .. ctx.kind end,
          --   },
          -- },
          -- stylua: ignore end
        },
      },
    },

    -- Use Rust implementation for better fuzzy matching performance (falls back to Lua if unavailable)
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true, window = { border = "single" } },
    cmdline = { enabled = true },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
      kind_icons = require("utils.icons").blink.kinds,
    },

    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer", "ripgrep" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        buffer = { max_items = 20 },
        ripgrep = { module = "blink-ripgrep", name = "Ripgrep", opts = {} },
        lsp = {
          fallbacks = {},
          should_show_items = true,
          max_items = 100,
          -- High score offset prioritizes LSP completions over other sources
          score_offset = 1000,
          show_autoImports = true,
          trigger_characters = { ".", '"', "'", "/", "@", "<" },
          -- Resolve additional details when item is inserted (lazy loading for performance)
          resolve_on_insert = true,
          -- filter = function(ctx, items)
          --   -- Prefer items from ts_ls over other LSP servers
          --   local ts_items = {}
          --   local other_items = {}
          --   for _, item in ipairs(items) do
          --     if item.source == "ts_ls" then
          --       table.insert(ts_items, item)
          --     else
          --       table.insert(other_items, item)
          --     end
          --   end
          --   -- Return ts_ls items first, then others
          --   return vim.list_extend(ts_items, other_items)
          -- end,
        },
        snippets = {
          max_items = 10,
          opts = {
            friendly_snippets = true,
            search_paths = { vim.fn.stdpath("config") .. "/snippets" },
            -- Share snippets across related filetypes (e.g., TS can use JS snippets)
            extended_filetypes = {
              typescript = { "javascript" },
              typescriptreact = { "javascript", "javascriptreact" },
              javascript = { "javascriptreact" },
              javascriptreact = { "javascript" },
            },
          },
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
