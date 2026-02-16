-- -------
-- source: https://github.com/rareitems/printer.nvim
-- ---------------------------------------------------
-- To add debug printing
--
return {
  "rareitems/printer.nvim",
  event = "BufEnter",
  ft = { "lua", "javascript", "typescript", "javascriptreact", "typescriptreact" },
  keys = {
    { "gp", mode = { "n", "v" } },
  },
  config = function()
    local formatter = function(inside, variable)
      return string.format("console.log('%s: ', %s);", inside, variable)
    end

    require("printer").setup({
      keymap = "gp",
      -- behavior = "yank",
      formatters = {
        lua = function(inside, variable)
          return string.format('print("%s: " .. %s)', inside, variable)
        end,
        javascript = formatter,
        typescript = formatter,
        javascriptreact = formatter,
        typescriptreact = formatter,
      },
      add_to_inside = function(text)
        return string.format("[L%s] %s", vim.fn.line("."), text)
      end,
    })
  end,
}
