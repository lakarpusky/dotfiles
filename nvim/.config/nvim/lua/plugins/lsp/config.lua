-- About:
----------
-- source: https://github.com/neovim/nvim-lspconfig
-- --------------------------------------------------
-- Easy configurations for various Laguage Server Protocols (LSP) servers,
-- allowing IDE-like features such as: code-completion, got to definition and error-checking.
--
-- Simplifies the setup process for using LSP with predefined
-- configurations for may programming languages.
--
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    "ravibrock/spellwarn.nvim",
    "dgagn/diagflow.nvim",
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  },
  config = function()
    local blink, u = require("blink.cmp"), require("utils")
    local border = u.icons.borders.dashed

    vim.lsp.set_log_level("ERROR")
    vim.diagnostic.config({
      -- Show inline diagnostics, source only if multiple
      virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      severity_sort = true,
      update_in_insert = false,
      underline = true,
      float = {
        border = border,
        source = "if_many",
        header = "",
        prefix = "",
        focusable = false,
        format = function(diagnostic)
          return string.format(" %s ", diagnostic.message)
        end,
        max_width = 80,
        wrap = true,
      },
    })

    u.fn.usercmd("LspInfo", function()
      vim.cmd("checkhealth vim.lsp")
    end, {})

    local capabilities = blink.get_lsp_capabilities()
    -- Performance optimizations: Enable snippet support and lazy-load completion details
    -- Only resolve documentation/details when item is selected, not for entire list
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = { "documentation", "detail", "additionalTextEdits" },
    }

    local default_config = {
      capabilities = capabilities,
      on_attach = u.lsp.on_attach,
      -- Performance: Wait 200ms after typing stops before sending changes to LSP
      flags = { debounce_text_changes = 200 },
      handlers = {
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = border,
          focusable = true,
          source = "always",
          pad_top = 1,
          pad_bottom = 1,
        }),
      },
    }

    vim.lsp.config("*", default_config)
    vim.lsp.enable({ "cssls", "eslint", "jsonls", "lua_ls", "yamlls", "pyright" })
  end,
}
