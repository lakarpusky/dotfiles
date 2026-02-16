local km = vim.keymap
local map = function(mode, lhs, rhs, opts)
  km.set(mode, lhs, rhs, vim.tbl_extend("force", { noremap = true, silent = true }, opts or {}))
end

-- File Explorer (depends on neo-tree.nvim)
-- stylua: ignore start
km.set("n", "<leader>ee", "<Cmd>Neotree toggle<CR>", { desc = "Toggle explorer" })
km.set("n", "<leader>ef", "<Cmd>Neotree reveal<CR>", { desc = "Find file" })
km.set("n", "<leader>er", "<Cmd>Neotree refresh<CR>", { desc = "Refresh explorer" })
km.set("n", "<leader>eb", function() require("buffer_manager.ui").toggle_quick_menu() end, { desc = "Toggle open editors" })
-- stylua: ignore end

-- Fold keymaps (these are vim defaults, just documenting them)
-- stylua: ignore start
km.set("n", "za", "za", { desc = "Toggle fold" })
km.set("n", "zM", "zM", { desc = "Close all folds" })
km.set("n", "zR", "zR", { desc = "Open all folds" })
-- stylua: ignore end

-- Window split keymaps
-- stylua: ignore start
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
-- stylua: ignore end

-- Tab management keymaps
-- stylua: ignore start
map("n", "<leader>tN", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
-- stylua: ignore end

-- Selection and movement keymaps
-- stylua: ignore start
map("n", "<S-Down>", "Vj", { desc = "Start line selection down (Shift + Down)" })
map("n", "<S-Up>", "Vk", { desc = "Start line selection up (Shift + Up)" })
map("n", "<M-BS>", "db", { desc = "Delete words backward (Alt + Delete)" })
map("n", "<M-Down>", ":m +1<CR>==", { desc = "Move line down (Alt + Down)" })
map("n", "<M-Up>", ":m -2<CR>==", { desc = "Move line up (Alt + Up)" })

map("i", "<S-Down>", "<Esc>Vj", { desc = "Start line selection down [i](Shift + Down)" })
map("i", "<S-Up>", "<Esc>Vk", { desc = "Start line selection up [i](Shift + Down)" })
map("i", "<M-BS>", "<C-w>", { desc = "Delete words backward (Alt + Delete)" })

map("v", "<S-Down>", "j", { desc = "Extend selection down (Shift + Down)" })
map("v", "<S-Up>", "k", { desc = "Extend selection up (Shift + Up)" })
map("v", "<M-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up (Alt + Down)" })
map("v", "I", "<Esc>i", { desc = "Cancel selection and enter insert mode" })
map("v", "<M-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down (Alt + Down)" })
-- stylua: ignore end

-- Insert mode line movement - slightly cleaner:
-- stylua: ignore start
map("i", "<M-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down [i]" })
map("i", "<M-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up [i]" })
-- stylua: ignore end

-- stylua: ignore start
map("n", "<leader>ch", ":noh<CR>", { desc = "Clear search highlights" })
map("n", "<leader>nr", "cgn", { desc = "Change current occurrence [type replacement]" })

map("n", "<leader>L", ":Lazy<CR>", { desc = "Opens Lazy plugins manager window" })
map("n", "<leader>M", ":Mason<CR>", { desc = "Opens Mason LSP manager window" })
-- stylua: ignore end

-- LSP keymaps (depends on nvim-lspkconfig)
if vim.lsp and vim.lsp.buf then
  -- stylua: ignore start
  map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
  map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
  map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
  map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
  -- stylua: ignore end
  map("n", "<leader>oi", function()
    vim.lsp.buf.execute_command({
      command = "_typescript.organizeImports",
      arguments = { require("utils.functions").getname(0) },
    })
  end, { desc = "Organize imports" })
end

-- Toggle Terminal
-- Thanks :: https://www.reddit.com/r/neovim/comments/1bjhadj/efficiently_switching_between_neovim_and_terminal/
-- stylua: ignore start
local exitTerm = function() vim.cmd(":lua Snacks.terminal.toggle()") end
map({ "n" }, "<C-t>", ":lua Snacks.terminal.toggle()<cr>", { desc = "Toggle Terminal" })
map({ "t" }, "<C-t>", exitTerm)
map("n", "<leader>th", function() Snacks.terminal(nil, { win = { position = "bottom", height = 0.3 } }) end, { desc = "Terminal horizontal" })
-- stylua: ignore end

-- DAP debugging keybindings
-- stylua: ignore start
map("n", "<F5>", function() require("dap").continue() end, { desc = "Debug: Start/Continue" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "Debug: Step Over" })
map("n", "<F11>", function() require("dap").step_into() end, { desc = "Debug: Step Into" })
map("n", "<F12>", function() require("dap").step_out() end, { desc = "Debug: Step Out" })
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
map("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Debug: Conditional Breakpoint" })
map("n", "<leader>dc", function() require("dap").run_to_cursor() end, { desc = "Debug: Run to Cursor" })
map("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Debug: Run Last" })
map("n", "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Debug: Toggle REPL" })
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Debug: Toggle UI" })
-- stylua: ignore end

-- Buffer management
-- stylua: ignore start
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>ba", "<cmd>%bd|e#<CR>", { desc = "Delete all buffers except current" })
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
-- stylua: ignore end

-- Quick save
-- stylua: ignore start
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>w<CR>a", { desc = "Save file" })
-- stylua: ignore end

-- Better paste (don't yank replaced text)
-- stylua: ignore
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Quick select all
-- stylua: ignore
map("n", "<C-a>", "ggVG", { desc = "Select all" })

-- LSP diagnostics and info
-- stylua: ignore start
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>ll", "<cmd>LspInfo<CR>", { desc = "LSP Info" })
map("n", "<leader>lr", "<cmd>LspRestart<CR>", { desc = "LSP Restart" })
-- stylua: ignore end

-- Format
-- stylua: ignore start
map("n", "<leader>fm", function() require("conform").format({ async = true, lsp_fallback = true }) end, { desc = "Format file" })
map("v", "<leader>fm", function() require("conform").format({ async = true, lsp_fallback = true }) end, { desc = "Format selection" })
-- stylua: ignore end

-- TypeScript enhancement commands
map("n", "<leader>ru", function()
  vim.lsp.buf.execute_command({ command = "_typescript.removeUnused", arguments = { vim.api.nvim_buf_get_name(0) } })
end, { desc = "Remove unused imports" })

map("n", "<leader>mi", function()
  vim.lsp.buf.execute_command({
    command = "_typescript.addMissingImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  })
end, { desc = "Add missing imports" })

map("n", "<leader>rf", function()
  vim.lsp.buf.execute_command({
    command = "_typescript.goToSourceDefinition",
    arguments = { vim.api.nvim_buf_get_name(0) },
  })
end, { desc = "Go to source definition" })

-- Inlay hints toggle
-- stylua: ignore
map("n", "<leader>ti", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle inlay hints" })

-- LSP lines toggle
map("n", "<leader>tl", function()
  local current = vim.diagnostic.config()
  vim.diagnostic.config({ virtual_lines = not current.virtual_lines })
end, { desc = "Toggle LSP lines" })

-- Enhanced Git workflow
-- stylua: ignore start
map("n", "<leader>gS", ":Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
map("n", "<leader>gR", ":Gitsigns reset_buffer<CR>", { desc = "Reset buffer" })
map("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>", { desc = "Undo stage hunk" })
map("n", "<leader>gd", ":Gitsigns diffthis<CR>", { desc = "Diff this" })
map("n", "<leader>gD", function() require("gitsigns").diffthis("~") end, { desc = "Diff this (cached)" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory %<CR>", { desc = "File git history" })
-- stylua: ignore end

-- Package info keybindings
-- stylua: ignore start
map("n", "<leader>ns", function() require("package-info").show() end, { desc = "Show package info" })
map("n", "<leader>nu", function() require("package-info").update() end, { desc = "Update package" })
map("n", "<leader>nd", function() require("package-info").delete() end, { desc = "Delete package" })
map("n", "<leader>ni", function() require("package-info").install() end, { desc = "Install package" })
map("n", "<leader>nc", function() require("package-info").change_version() end, { desc = "Change version" })
-- stylua: ignore end
