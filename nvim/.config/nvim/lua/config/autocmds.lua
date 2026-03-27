local fn = require("utils.functions")
local cursor_group = fn.augroup("CursorLine", { clear = true })

-- Show cursor line only in active window
fn.autocmd({ "InsertLeave", "WinEnter" }, {
  group = cursor_group,
  callback = function()
    if vim.bo.buftype == "" then -- only for normal buffers
      vim.wo.cursorline = true
    end
  end,
})

-- stylua: ignore
fn.autocmd({ "InsertEnter", "WinLeave" }, {
  group = cursor_group,
  callback = function() vim.wo.cursorline = false end,
})

-- Auto-open dashboard when no files are open
fn.autocmd("BufDelete", {
  group = fn.augroup("DashboardAutoOpen", { clear = true }),
  callback = function()
    local buffers = vim.fn.getbufinfo({ buflisted = 1 })
    if #buffers <= 1 then
      vim.defer_fn(function()
        if #vim.fn.getbufinfo({ buflisted = 1 }) == 0 then
          Snacks.dashboard()
        end
      end, 50)
    end
  end,
})

-- Auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
fn.autocmd({ "FocusGained", "BufEnter" }, {
  group = fn.augroup("AutoReload", { clear = true }),
  callback = function()
    if vim.fn.mode() ~= "c" and vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

-- Auto enter insert mode for any terminal buffer
fn.autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
  end,
})

-- Disable line numbers in terminal
fn.autocmd("TermOpen", {
  group = fn.augroup("TerminalSettings", { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert") -- useful for terminal
  end,
})

-- Highlight on Yank
-- stylua: ignore
fn.autocmd("TextYankPost", {
  group = fn.augroup("HighlightYank", { clear = true }),
  callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
})

-- Disable auto-comment on new lines (prevents unwanted comment continuation)
-- c: auto-wrap comments, r: insert comment leader on Enter, o: insert comment leader with 'o'
fn.autocmd("FileType", {
  group = fn.augroup("DisableAutoComment", { clear = true }),
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Return to last edit position when opening files
-- Uses the " mark which Vim automatically sets to the last cursor position
fn.autocmd("BufReadPost", {
  group = fn.augroup("LastEditPosition", { clear = true }),
  callback = function()
    local mark, lcount = vim.api.nvim_buf_get_mark(0, '"'), vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Performance: Disable diagnostics in node_modules (prevents LSP lag on large dependency files)
fn.autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*/node_modules/*",
  command = "lua vim.diagnostic.enable(false, { bufnr = 0 })",
})

-- Enable spell checking for certain file types
fn.autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.txt", "*.md", "*.tex" },
  command = "setlocal spell",
})

-- Show all characters (disable concealing) in text/markdown/json files
-- Prevents hiding of special chars like backticks, quotes, etc.
fn.autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.txt", "*.md", "*.json" },
  command = "setlocal conceallevel=0",
})

-- Attach specific keybindings in which-key for specific filetypes
local present, _ = pcall(require, "which-key")
-- stylua: ignore start
if not present then return end
local _, pwk = pcall(require, "plugins.which-key.setup")

fn.autocmd("BufEnter", { pattern = "*.md", callback = function() pwk.attach_markdown(0) end })
fn.autocmd("BufEnter", { pattern = { "package.json" }, callback = function() pwk.attach_npm(0) end })
fn.autocmd("BufEnter", {
  pattern = { "*test.js", "*test.ts", "*test.tsx", "*spec.ts", "*spec.tsx" },
  callback = function() pwk.attach_jest(0) end,
})
