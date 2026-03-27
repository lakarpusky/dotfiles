-- -------
-- source: https://github.com/Bekaboo/dropbar.nvim
-- -------------------------------------------------
-- ide-like breadcrumbs
--
return {
  "Bekaboo/dropbar.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    -- optional, but required for fuzzy finder support
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  opts = {
    icons = {
      ui = { bar = { separator = "  " }, menu = { separator = "" } },
      kinds = { symbols = require("utils.icons").dropbar.kinds },
    },
    bar = {
      sources = function(buf, _)
        local sources, utils = require("dropbar.sources"), require("dropbar.utils")
        -- stylua: ignore start
        if vim.bo[buf].ft == "markdown" then return { sources.markdown } end
        if vim.bo[buf].buftype == "terminal" then return { sources.terminal } end
        return { utils.source.fallback({ sources.lsp, sources.treesitter }) }
      end,
    },
  },
  config = function(_, opts)
    require("dropbar").setup(opts)

    local highlights = {
      DropBarKindFunction = "@function",
      DropBarKindMethod = "@method",
      DropBarKindVariable = "@variable",
      DropBarKindConstant = "@constant",
      DropBarKindClass = "@type",
      DropBarKindInterface = "@type",
      DropBarKindModule = "@namespace",
      DropBarKindProperty = "@property",
      DropBarKindField = "@field",
      DropBarKindConstructor = "@constructor",
      DropBarKindEnum = "@type",
      DropBarKindStruct = "@type",
      DropBarKindObject = "@constant.builtin",
      DropBarKindArray = "@type",
      DropBarKindKey = "@property",
      DropBarKindNull = "@constant.builtin",
      DropBarKindNumber = "@number",
      DropBarKindString = "@string",
      DropBarKindBoolean = "@boolean",
      DropBarKindPackage = "@namespace",
      DropBarKindNamespace = "@namespace",
    }

    for group, link in pairs(highlights) do
      vim.api.nvim_set_hl(0, group, { link = link })
    end
  end,
  keys = {
    -- stylua: ignore start
    { "<leader>;", function() require("dropbar.api").pick() end, desc = "Winbar pick" },
    { "[;", function() require("dropbar.api").goto_context_start() end, desc = "Go to start of current context" },
    { "];", function() require("dropbar.api").select_next_context() end, desc = "Select next context" },
  },
}
