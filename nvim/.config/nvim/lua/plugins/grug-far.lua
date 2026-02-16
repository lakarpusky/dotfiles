-- ---------
-- source: https://github.com/MagicDuck/grug-far.nvim
-- ----------------------------------------------------
-- Project-wide find and replace with live preview (ripgrep-powered)
--
return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>sr",
      function() require("grug-far").toggle_instance({ instanceName = "main" }) end,
      desc = "Search and replace (toggle)",
    },
    {
      "<leader>sw",
      function()
        require("grug-far").open({
          instanceName = "main",
          prefills = { search = vim.fn.expand("<cword>") },
        })
      end,
      desc = "Search and replace word under cursor",
    },
  },
  opts = {
    windowCreationCommand    = "botright vsplit | vertical resize 50",
    showCompactInputs        = true,  -- removes blank hint lines, cleaner layout
    showInputsTopPadding     = false,
    showInputsBottomPadding  = false,
    resultsSeparatorLineChar = "─",
    helpLine                 = { enabled = false },       -- no help keymaps bar (VS Code has none)
    folding                  = { foldcolumn = "0" },      -- no fold gutter, cleaner left edge
    resultLocation           = { showNumberLabel = false }, -- no [42] labels on right
  },
  config = function(_, opts)
    require("grug-far").setup(opts)

    -- Hide grug-far buffer from the buffer list (buffer_manager only shows listed buffers)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "grug-far",
      callback = function(ev) vim.bo[ev.buf].buflisted = false end,
    })

    -- Labels: VS Code light blue, bold
    vim.api.nvim_set_hl(0, "GrugFarInputLabel",          { fg = "#9cdcfe", bold = true })
    -- Placeholders: very dim so they don't compete with real input
    vim.api.nvim_set_hl(0, "GrugFarInputPlaceholder",    { fg = "#3a3a3a", italic = true })
    -- Results separator line (< ripgrep >---)
    vim.api.nvim_set_hl(0, "GrugFarResultsHeader",       { fg = "#007acc", bold = true })
    -- "N matches in M files" — teal, more visible
    vim.api.nvim_set_hl(0, "GrugFarResultsStats",        { fg = "#4ec9b0", italic = true })
    -- File paths in results — VS Code string orange, bold (no underline like VS Code)
    vim.api.nvim_set_hl(0, "GrugFarResultsPath",         { fg = "#ce9178", bold = true })
    -- Line numbers — nearly invisible, dim
    vim.api.nvim_set_hl(0, "GrugFarResultsLineNr",       { fg = "#3a3a3a" })
    -- Cursor line number — slightly brighter when on a match
    vim.api.nvim_set_hl(0, "GrugFarResultsCursorLineNo", { fg = "#858585" })
    -- Match highlight — VS Code orange amber background (#623300 = VS Code findMatchHighlight)
    vim.api.nvim_set_hl(0, "GrugFarResultsMatch",        { bg = "#623300" })
    -- Replace diff: added lines green tint, removed lines red tint
    vim.api.nvim_set_hl(0, "GrugFarResultsMatchAdded",   { bg = "#1a3a1a" })
    vim.api.nvim_set_hl(0, "GrugFarResultsMatchRemoved", { bg = "#3a1515" })
  end,
}
