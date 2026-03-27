-- --------
-- source: https://github.com/mfussenegger/nvim-lint
-- --------------------------------------------------
-- Provides linting capabilities by running various linters
-- and reporting the results.
-- -----------------------------
-- Complement the built-in LSP support and can be
-- configured to run specific linters based on file type.
--
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("lint").linters_by_ft = {
      css = { "stylelint" },
      scss = { "stylelint" },
      less = { "stylelint" },
      json = { "jsonlint" },
      jsonc = { "jsonlint" },
      yaml = { "yamllint" },
      lua = { "luacheck" },
      python = { "ruff" },
    }

    local u = require("utils")
    -- Debounced linting for performance
    u.fn.autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = u.fn.augroup("lint", { clear = true }),
      callback = function()
        vim.defer_fn(function()
          require("lint").try_lint()
        end, 200)
      end,
    })
  end,
}
