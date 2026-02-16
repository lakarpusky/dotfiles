-- About:
----------
-- source: https://github.com/neovim/nvim-lspconfig
-- --------------------------------------------------
-- Easy configurations for various Laguage Server Protocols (LSP) servers,
-- allowing IDE-like features such as: code-completion, got to definition and error-checking.
--
-- Simplifies the setup process for using LSP with predfined
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

    -- stylua: ignore
    u.fn.usercmd("LspInfo", function() vim.cmd("checkhealth vim.lsp") end, {}) -- Add LSP commands

    local handlers = {
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = border,
        focusable = true,
        source = "always",
        pad_top = 1,
        pad_bottom = 1,
      }),
    }

    for method, handler in pairs(handlers) do
      vim.lsp.handlers[method] = handler
    end

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
    }

    local cssls = {
      settings = {
        css = { lint = { emptyRules = "ignore" } },
        scss = {
          lint = { emptyRules = "ignore" },
          completion = {
            -- Auto-add semicolons and trigger value completions for better DX
            completePropertyWithSemicolon = true,
            triggerPropertyValueCompletion = true,
          },
        },
        less = {
          lint = { emptyRules = "ignore" },
          completion = {
            completePropertyWithSemicolon = true,
            triggerPropertyValueCompletion = true,
          },
        },
      },
    }

    local jsonls = {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          -- Why the option is recommended
          -- https://github.com/b0o/SchemaStore.nvim/issues/8
          validate = { enable = true },
        },
      },
    }

    local yamlls = {
      settings = {
        yaml = {
          schemaStore = {
            -- You must disable built-in schemaStore support if you want to use
            -- this plugin and its advanced options like `ignore`.
            enable = false,
            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
            url = "",
          },
          schemas = require("schemastore").yaml.schemas(),
        },
      },
    }

    local lua_ls = {
      settings = {
        codeLens = { enable = true },
        Lua = {
          runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
          workspace = {
            checkThirdParty = false,
          },
          telemetry = { enable = false },
          completion = { callSnippet = "Replace" },
          format = { enable = false },
          diagnostics = {
            globals = { "vim", "package" },
          },
        },
      },
    }

    local ts_ls = {
      settings = {
        typescript = {
          codeLens = true,
          updateImportsOnFileMove = { enabled = "always" },
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
          },
          preferences = {
            importModuleSpecifierPreference = "relative",
            includePackageJsonAutoImports = "on",
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            completeFunctionCalls = true,
          },
          suggest = {
            autoImports = true,
            includeCompletionsForModuleExports = true,
            includeCompletionsForImportStatements = true,
          },
        },
        javascript = {
          updateImportsOnFileMove = { enabled = "always" },
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
          preferences = {
            importModuleSpecifierPreference = "relative",
            includePackageJsonAutoImports = "on",
            quotePreference = "single",
            includeCompletionsForModuleExports = true,
            includeCompletionsForImportStatements = true,
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            completeFunctionCalls = true,
          },
          suggest = {
            autoImports = true,
            completeFunctionCalls = true,
            includeAutomaticOptionalChainCompletions = true,
            includeCompletionsForModuleExports = true,
            includeCompletionsForImportStatements = true,
          },
          format = { enable = false },
        },
        completions = {
          completeFunctionCalls = true,
          includeCompletionsForModuleExports = true,
        },
      },
      -- Enable JSDoc support for type checking in JS
      init_options = {
        hostInfo = "neovim",
        preferences = {
          includeCompletionsForModuleExports = true,
          includeCompletionsForImportStatements = true,
          includeCompletionsWithInsertText = true,
          includeCompletionsWithClassMemberSnippets = true,
          includeCompletionsWithObjectLiteralMethodSnippets = true,
          importModuleSpecifierPreference = "relative",
          includeAutomaticOptionalChainCompletions = true,
        },
      },
    }

    local servers = {
      cssls = cssls,
      lua_ls = lua_ls,
      ts_ls = ts_ls,
      jsonls = jsonls,
      yamlls = yamlls,
      html = {},
      emmet_ls = {},
      stylelint_lsp = {},
      eslint = {
        settings = { workingDirectory = { mode = "location" } },
      },
    }

    vim.lsp.config("*", default_config)

    for server, config in pairs(servers) do
      if next(config) ~= nil then
        vim.lsp.config(server, config)
      end
    end

    vim.lsp.enable(vim.tbl_keys(servers))
  end,
}
