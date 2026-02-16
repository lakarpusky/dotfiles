return {
  { "nvim-lua/plenary.nvim" },
  { "christoomey/vim-tmux-navigator" },
  { "xzbdmw/colorful-menu.nvim" },
  { "tmux-plugins/vim-tmux" },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
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
}
