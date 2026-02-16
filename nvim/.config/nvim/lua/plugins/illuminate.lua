-- ---------
-- source: https://github.com/RRethy/vim-illuminate
-- --------------------------------------------------
-- Highlights all occurrences of the word under the cursor
--
return {
  "RRethy/vim-illuminate",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    delay = 200,
    providers = { "lsp", "treesitter" },
    large_file_cutoff = 2000,
    large_file_overrides = { providers = { "lsp" } },
    filetypes_denylist = {
      "neo-tree", "dashboard", "lazy", "mason", "trouble", "buffer_manager",
    },
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
  end,
}
