return {
  { "nvim-lua/plenary.nvim" },
  { "christoomey/vim-tmux-navigator" },
  { "xzbdmw/colorful-menu.nvim" },
  { "tmux-plugins/vim-tmux" },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      win = { border = require("utils.icons").borders.dashed },
      icons = { rules = false, breadcrumb = " ", separator = "󱦰 ", group = "󰹍 " },
    },
  },
  {
    "axelvc/template-string.nvim",
    event = "InsertEnter",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = true,
  },
  { "dmmulroy/ts-error-translator.nvim", ft = { "typescript", "typescriptreact" } },
  { "b0o/schemastore.nvim", ft = { "json", "yaml" }, lazy = true, version = false },
  { "kylechui/nvim-surround", version = "^3.0.0", event = { "BufReadPre", "BufNewFile" }, config = true },
  {
    "echasnovski/mini.icons",
    lazy = false,
    config = function()
      require("mini.icons").setup()
      MiniIcons.mock_nvim_web_devicons()
    end,
  },

  -- ---------
  -- source: https://github.com/folke/flash.nvim
  -- ---------------------------------------------
  -- To navigate your code with search labels, enhanced character motions, and Treesitter integration.
  --
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      -- stylua: ignore start
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      --stylua: ignore end
    },
  },
}
