-- --------
-- source: https://github.com/stevearc/conform.nvim
-- -------------------------------------------------
-- Supports range formatting, embedded code blocks, and custom formatters.
--
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        less = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "mdformat" },
        lua = { "stylua" },
      },

      -- CRITICAL: Async formatting prevents blocking on save (better UX for large files)
      -- Never use LSP formatting (we use prettierd/stylua which are faster)
      format_after_save = {
        lsp_format = "never",
        timeout_ms = 1000, -- handle large files without blocking
        async = true,
        -- NOTE: Auto-organize imports removed from save callback.
        -- Use <leader>oi (TSToolsOrganizeImports) manually instead.
        -- Auto-organizing on every save can be disruptive mid-refactor.
      },

      -- Default options for manual formatting (<leader>fm)
      default_format_opts = { timeout_ms = 1000, lsp_format = "never" },
    })
  end,
}
