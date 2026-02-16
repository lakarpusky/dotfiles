local fn = require("utils.functions")
local M = {}

M.status = function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    return ""
  end
  return "LSP"
end

M.on_attach = function(client, bufnr)
  -- CRITICAL: Disable LSP formatting in favor of conform.nvim (faster, more consistent)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  -- Performance: Disable semantic tokens, treesitter provides better syntax highlighting
  client.server_capabilities.semanticTokensProvider = nil

  -- Inlay hints: Only enable for TS/Lua (avoid clutter in other languages)
  if client.supports_method("textDocument/inlayHint") then
    local ft = vim.bo[bufnr].filetype
    if ft == "typescript" or ft == "typescriptreact" or ft == "lua" then
      vim.lsp.inlay_hint.enable(true, { buffer = bufnr })
    else
      vim.lsp.inlay_hint.enable(false, { buffer = bufnr })
    end
  end

  -- CodeLens: Auto-refresh on buffer events (shows inline actions/references)
  if client.supports_method("textDocument/codeLens") then
    vim.lsp.codelens.refresh()
    fn.autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh,
    })
  end

  -- TypeScript-specific: Add organize imports keybinding
  if client.name == "ts_ls" then
    vim.keymap.set("n", "<leader>oi", function()
      vim.lsp.buf.execute_command({
        command = "_typescript.organizeImports",
        arguments = { fn.getname(0) },
      })
    end, { buffer = bufnr, noremap = true, silent = true })
  end

  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover({
      border = "rounded",
      width = 80,
      max_width = 80,
      max_height = 30,
    })
  end, { buffer = bufnr, desc = "Hover Documentation" })

  -- "<cmd>lua vim.lsp.buf.definition()<CR>",
  vim.keymap.set("n", "<M-LeftMouse>", function()
    Snacks.picker.lsp_definitions()
  end, { buffer = bufnr, desc = "Go to Definition" })
end

return M
