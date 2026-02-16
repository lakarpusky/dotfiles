local M = {}

-- Attach markdown-specific keybindings
function M.attach_markdown(bufnr)
  local wk = require("which-key")
  wk.add({
    { "<leader>m", group = "markdown", buffer = bufnr },
    { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Preview", buffer = bufnr },
    { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Stop Preview", buffer = bufnr },
    { "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Preview", buffer = bufnr },
    { "<leader>mh", "<cmd>Telescope heading<cr>", desc = "Browse Headings", buffer = bufnr },
    { "<leader>mc", "<cmd>lua require('utils.markdown').toggle_checkbox()<cr>", desc = "Toggle Checkbox", buffer = bufnr },
  })
end

-- Attach npm/package.json-specific keybindings
function M.attach_npm(bufnr)
  local wk = require("which-key")
  wk.add({
    { "<leader>n", group = "npm", buffer = bufnr },
    { "<leader>ni", "<cmd>!npm install<cr>", desc = "npm install", buffer = bufnr },
    { "<leader>nu", "<cmd>!npm update<cr>", desc = "npm update", buffer = bufnr },
    { "<leader>nr", "<cmd>!npm run<cr>", desc = "npm run", buffer = bufnr },
    { "<leader>nt", "<cmd>!npm test<cr>", desc = "npm test", buffer = bufnr },
    { "<leader>nb", "<cmd>!npm run build<cr>", desc = "npm build", buffer = bufnr },
    { "<leader>nd", "<cmd>!npm run dev<cr>", desc = "npm dev", buffer = bufnr },
  })
end

-- Attach jest test-specific keybindings
function M.attach_jest(bufnr)
  local wk = require("which-key")
  wk.add({
    { "<leader>j", group = "jest", buffer = bufnr },
    { "<leader>jt", "<cmd>!npm test -- %<cr>", desc = "Test Current File", buffer = bufnr },
    { "<leader>ja", "<cmd>!npm test<cr>", desc = "Test All", buffer = bufnr },
    { "<leader>jw", "<cmd>!npm test -- --watch<cr>", desc = "Test Watch", buffer = bufnr },
    { "<leader>jc", "<cmd>!npm test -- --coverage<cr>", desc = "Test Coverage", buffer = bufnr },
  })
end

-- Attach spectre-specific keybindings
function M.attach_spectre(bufnr)
  local wk = require("which-key")
  wk.add({
    { "<leader>s", group = "spectre", buffer = bufnr },
    { "<leader>sr", desc = "Replace All", buffer = bufnr },
    { "<leader>sc", desc = "Replace Current", buffer = bufnr },
    { "<leader>sq", desc = "Send to Quickfix", buffer = bufnr },
  })
end

-- Attach nvim-tree-specific keybindings
function M.attach_nvim_tree(bufnr)
  local wk = require("which-key")
  wk.add({
    { "<leader>e", group = "explorer", buffer = bufnr },
    { "<leader>ef", desc = "Focus Explorer", buffer = bufnr },
    { "<leader>et", desc = "Toggle Explorer", buffer = bufnr },
    { "<leader>er", desc = "Refresh Explorer", buffer = bufnr },
  })
end

return M
