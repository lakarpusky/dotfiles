-- About:
----------
-- source: https://github.com/mason-org/mason.nvim
-- -------------------------------------------------
-- Helps manage the instalation and configuration of language servers (LS),
-- making it easier to set up dev environments.
-- -----------
-- It works alognside Mason.nvim to automatically install and
-- enable Language Servers as needed.
--
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason, mason_lsp = require("mason"), require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = { icons = require("utils.icons").mason },
    })

    mason_lsp.setup({
      ensure_installed = {
        "ts_ls",
        "html",
        "cssls",
        "stylelint_lsp",
        "lua_ls",
        "emmet_ls",
        "eslint",
        "jsonls",
        "yamlls",
      },
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettierd",
        "stylua",
        "eslint_d",
        "mdformat",
        "jsonlint",
        "yamllint",
        "luacheck",
        "js-debug-adapter",
      },
      auto_update = true,
      run_on_start = true,
    })
  end,
}
