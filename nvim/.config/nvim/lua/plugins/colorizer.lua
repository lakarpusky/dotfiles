-- --------
-- source: https://github.com/catgoose/nvim-colorizer.lua
-- --------------------------------------------------------
-- Color highligthing of CSS and other file types.
--
return {
  "NvChad/nvim-colorizer.lua",
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
}
