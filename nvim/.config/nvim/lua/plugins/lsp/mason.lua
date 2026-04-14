-- About:
----------
-- source: https://github.com/mason-org/mason.nvim
-- -------------------------------------------------
-- Helps manage the installation and configuration of language servers (LS),
-- making it easier to set up dev environments.
-- -----------
-- It works alongside Mason.nvim to automatically install and
-- enable Language Servers as needed.
--
return {
  "williamboman/mason.nvim",
  dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  config = function()
    local mason = require("mason")
    local mason_tool_installer = require("mason-tool-installer")
    mason.setup({ ui = { icons = require("utils.icons").mason } })
    -- Single source of truth for all Mason-managed tools
    -- LSP servers + formatters + linters + debug adapters
    mason_tool_installer.setup({
      ensure_installed = {
        "html-lsp",
        "css-lsp",
        "lua-language-server",
        "emmet-ls",
        "json-lsp",
        "yaml-language-server",
        -- Formatters
        "prettierd",
        "stylua",
        "mdformat",
        -- Linters
        "eslint-lsp",
        "stylelint-language-server",
        "jsonlint",
        "yamllint",
        "luacheck",
        "js-debug-adapter",
        -- python specific
        "pyright",
        "ruff",
        "debugpy",
      },
      auto_update = true,
      run_on_start = true,
    })
  end,
}
