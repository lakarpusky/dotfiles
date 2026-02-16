-- -------
-- source: https://github.com/hiphish/rainbow-delimiters.nvim
-- ------------------------------------------------------------
-- Rainbow delimiters with Tree-sitter
--
return {
  "hiphish/rainbow-delimiters.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "LspInfo", "LspInstall", "LspUninstall" },
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
}
