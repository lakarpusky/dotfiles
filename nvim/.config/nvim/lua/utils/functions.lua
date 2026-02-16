local vim = vim
local M = {}

M.sethl = vim.api.nvim_set_hl
M.augroup = vim.api.nvim_create_augroup
M.autocmd = vim.api.nvim_create_autocmd
M.usercmd = vim.api.nvim_create_user_command
M.getname = vim.api.nvim_buf_get_name

M.delay = function(fn, ms)
  return vim.defer_fn(fn, ms or 0)
end

M.window = function(n)
  return vim.api.nvim_win_get_number(n or 0)
end

return M
