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
        md = { "mdformat" },
        lua = { "stylua" },
      },

      -- CRITICAL: Async formatting prevents blocking on save (better UX for large files)
      -- Never use LSP formatting (we use prettierd/stylua which are faster)
      format_after_save = {
        lsp_format = "never",
        timeout_ms = 1000, -- handle large files without blocking
        async = true,
        -- Auto-organize imports after formatting for TS files
        callback = function()
          if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
            vim.lsp.buf.execute_command({
              command = "_typescript.organizeImports",
              arguments = { require("utils.functions").getname(0) },
            })
          end
        end,
      },

      -- Default options for manual formatting (<leader>fm)
      default_format_opts = { timeout_ms = 1000, lsp_format = "never" },
    })
  end,
}
