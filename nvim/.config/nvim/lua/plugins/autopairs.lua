-- --------
-- source: https://github.com/windwp/nvim-autopairs
-- --------------------------------------------------
-- Automatiaclly inserts and manages paired characters like
-- brackets and quotes as you type, enhancing coding efficiency.
--
return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = { "saghen/blink.cmp" },
  config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
        javascriptreact = { "template_string" },
        typescript = { "template_string" },
        typescriptreact = { "template_string" },
        java = false,
      },
      enable_afterquote = true,
      enable_check_bracket_line = false, -- Don't add pairs if it already has a close pair
    })

    -- Integrate with blink.cmp - Hook into blink's completion events
    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpCompletionMenuOpen",
      callback = function()
        autopairs.disable()
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpCompletionMenuClose",
      callback = function()
        autopairs.enable()
      end,
    })
  end,
}
