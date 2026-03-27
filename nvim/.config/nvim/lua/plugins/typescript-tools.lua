-- --------
-- source: https://github.com/pmizio/typescript-tools.nvim
-- --------------------------------------------------------
-- Direct tsserver communication (no LSP protocol wrapper).
-- Replaces ts_ls with better performance and first-class
-- TypeScript commands (organize imports, remove unused, etc.)
--
return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  opts = {
    on_attach = function(client, bufnr)
      -- Reuse shared on_attach for formatting/semantic tokens/inlay hints/codelens
      require("utils.lsp").on_attach(client, bufnr)
    end,
    settings = {
      separate_diagnostic_server = true,
      publish_diagnostic_on = "insert_leave",
      expose_as_code_action = "all",
      complete_function_calls = true,
      code_lens = "all",
      jsx_close_tag = { enable = false },
      tsserver_file_preferences = {
        -- Import style
        importModuleSpecifierPreference = "relative",
        includePackageJsonAutoImports = "on",
        -- Inlay hints
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
        -- Completions
        includeCompletionsForModuleExports = true,
        includeCompletionsForImportStatements = true,
        includeCompletionsWithInsertText = true,
        includeCompletionsWithClassMemberSnippets = true,
        includeCompletionsWithObjectLiteralMethodSnippets = true,
        includeAutomaticOptionalChainCompletions = true,
        -- JS quote style
        quotePreference = "single",
      },
      -- Disable tsserver formatting (conform.nvim handles this)
      tsserver_format_options = {
        allowIncompleteCompletions = false,
        allowRenameOfImportPath = false,
      },
    },
  },
  keys = {
    -- stylua: ignore start
    { "<leader>oi", "<cmd>TSToolsOrganizeImports<CR>", desc = "Organize imports" },
    { "<leader>ru", "<cmd>TSToolsRemoveUnusedImports<CR>", desc = "Remove unused imports" },
    { "<leader>mi", "<cmd>TSToolsAddMissingImports<CR>", desc = "Add missing imports" },
    { "<leader>rf", "<cmd>TSToolsGoToSourceDefinition<CR>", desc = "Go to source definition" },
    { "<leader>fa", "<cmd>TSToolsFixAll<CR>", desc = "Fix all TS errors" },
    { "<leader>rF", "<cmd>TSToolsRenameFile<CR>", desc = "Rename file (update imports)" },
    -- stylua: ignore end
  },
}
