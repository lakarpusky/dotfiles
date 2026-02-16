-- -------
-- source: https://github.com/mg979/vim-visual-multi
-- --------------------------------------------------
-- vscode-like keybinds for bulk world replacing
--
return {
  "mg979/vim-visual-multi",
  branch = "master",
  keys = {
    { "<C-d>", mode = { "n", "v" } },
  },
  init = function()
    vim.g.VM_maps = {
      ["Find Under"] = "<C-d>",
      ["Find Subword Under"] = "<C-d>",
      ["Select All"] = "<C-S-l>",
      ["Skip Region"] = "<C-k><C-d>",
    }
    vim.g.VM_default_mappings = 0
  end,
}
