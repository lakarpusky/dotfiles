-----------------------
-- Bootstrap lazy.vim
-----------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "DaikyXendo/nvim-material-icon",
  spec = {
    { import = "plugins.lsp" },
    { import = "plugins" },
  },
}, {
  checker = { enabled = true, notity = false },
  change_detection = { notify = false },
  git = { timeout = 300 }, -- from default (120) to 300 bc some clone timeout checks
  ui = {
    border = require("utils.icons").borders.dashed,
    icons = require("utils.icons").lazy,
  },
})
