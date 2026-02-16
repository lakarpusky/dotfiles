-- ---------
-- source: https://github.com/folke/lazydev.nvim
-- -----------------------------------------------
-- Provides full vim.* API autocompletion in Neovim Lua config files.
-- Replaces the manual workspace.library approach in lua_ls config.
--
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
