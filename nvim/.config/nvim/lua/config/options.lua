-- Leader Key (set before lazy.vim loads)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.editorconfig = false -- disable editor config as VSCode does not have it on by default

-- vim.cmd("let g:netrw_liststyle = 3")
local opt = vim.opt

-- Performance & Behavior
opt.swapfile = false
opt.backup = false -- no backup files
opt.writebackup = false -- no backup before overwriting
opt.undofile = true -- persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undo" -- undo directory
opt.updatetime = 250 -- faster update time
opt.timeoutlen = 300 -- faster key sequence timeout
opt.redrawtime = 1500 -- max time for syntax highlighting
opt.lazyredraw = false -- don't set true, causes issues with modern nvim

-- Buffer & Window Behavior
-- switchbuf: When switching buffers, prefer: last window -> existing tab -> already open window
opt.switchbuf = { "uselast", "usetab", "useopen" }
opt.confirm = true -- confirm before closing unsaved

-- Line display
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
opt.cursorline = true
-- Performance: Only highlight line number, not entire line (reduces visual noise and improves performance)
opt.cursorlineopt = "number"
-- Always show signcolumn (width=1) to prevent text shifting when diagnostics appear
opt.signcolumn = "yes:1"
opt.colorcolumn = "120" -- visual ruler
opt.showmode = false -- don't display mode
opt.showcmd = false -- don't show command in last line
opt.ruler = false -- don't show cursor position (statusline handles this)

-- Scrolling
opt.scrolloff = 8 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.smoothscroll = true -- smooth scrolling (nvim 0.10+)

-- Text wrapping
opt.wrap = true -- display wrapping
opt.linebreak = true -- break at words for display
opt.textwidth = 0 -- no automatic line breaks
opt.breakindent = true -- wrapped lines continue visually indented

-- Visual indicators
opt.list = true -- show whitespace characters
opt.listchars = { tab = " ", trail = "·", nbsp = "%", extends = "▶", precedes = "◀" }

-- Colors
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.title = true -- Allows neovim to send the Terminal details of the current window, instead of just getting 'v'

-- Indentation
opt.tabstop = 2 -- 2 spaces for tabs (also prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting a new one
opt.smartindent = true -- smart auto-indenting

-- Allow backspace on indent, end of line or insert mode start position
opt.backspace = { "indent", "eol", "start" }

-- System integration
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
opt.mouse = "a" -- enable mouse support

-- Search
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if search include mixed case, assumes we want case-sensitive
opt.incsearch = true -- incremental search
opt.hlsearch = true -- highlight search results

-- Better grep
opt.grepprg = "rg --hidden --vimgrep --smart-case --glob=!.git"
opt.grepformat = "%f:%l:%c:%m" -- grep output format

-- Splits
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom
-- Keep the text on the same screen line when opening splits (nvim 0.9+)
opt.splitkeep = "screen"

-- Completion & Command Line
-- Fuzzy command-line completion: e.g. `:e fi` matches `file.txt`
opt.wildoptions = "fuzzy,pum" -- fuzzy matching + popup menu
opt.completeopt = { "menu", "menuone", "noselect" } -- show menu even for single match, don't auto-select
opt.pumheight = 15 -- max height for completion popup
opt.cmdheight = 0 -- hide command line when not in use (modern UI)

-- Special modes
opt.virtualedit = "block" -- visual block beyond line end
opt.inccommand = "split" -- live preview of substitutions

-- Cursor shape
opt.guicursor = "n-v-c-sm:block-nCursor-blinkwait50-blinkon50-blinkoff50,"
  .. "i-ci-ve:ver25-Cursor-blinkon100-blinkoff100,"
  .. "r-cr-o:hor20"

-- Markdown settings
vim.g.markdown_fenced_languages = {
  "html",
  "javascript",
  "typescript",
  "css",
  "scss",
  "lua",
  "vim",
  "bash",
  "json",
}
