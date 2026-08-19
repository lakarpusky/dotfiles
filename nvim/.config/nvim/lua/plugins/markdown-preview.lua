-- --------
-- source: https://github.com/iamcco/markdown-preview.nvim
-- --------------------------------------------------------
-- Markdown preview in browser with live updates
--
return {
  "OXY2DEV/markview.nvim",
  ft = { "markdown" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    preview = {
      enable = false, -- don't render on attach; manual only
      icon_provider = "internal",
    },
  },
  keys = {
    { "<leader>mp", "<CMD>Markview Toggle<CR>", desc = "Markview: toggle preview (global)" },
    -- or buffer-scoped: "<CMD>Markview toggle<CR>"
  },
}
