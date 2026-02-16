-- -------
-- source: https://github.com/Mofiqul/vscode.nvim
-- ------------------------------------------------
-- Color schema inspired by Visual Studio Code
--
return {
  "Mofiqul/vscode.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = false,
    italic_comments = true,
    italic_inlayhints = true,
    underline_links = true,
    disable_nvimtree_bg = true,
    terminal_colors = true,

    color_overrides = {
      vscSelection = "#264F78",
      vscPopupFront = "#CCCCCC",
      vscPopupBack = "#1e1e1e",

      -- Main editor backgrounds
      vscBack = "#1e1e1e", -- Main editor background
      vscTabCurrent = "#1e1e1e", -- Active tab
      vscTabOther = "#2d2d30", -- Inactive tabs

      -- Panel and sidebar backgrounds
      vscSideBar = "#252526", -- Sidebar (Explorer, etc.)
      vscActivityBar = "#333333", -- Activity bar (far left)
      vscPanel = "#181818", -- Bottom panel (Terminal, Problems, etc.)
      vscStatusBar = "#007acc", -- Status bar

      -- Popup and dialog backgrounds
      -- vscPopupBack = "#252526", -- Context menus, autocomplete
      vscInputBack = "#3c3c3c", -- Input fields
      vscDropdownBack = "#3c3c3c", -- Dropdowns

      -- Window chrome
      vscTitleBar = "#3c3c3c", -- Title bar
      vscMenuBar = "#3c3c3c", -- Menu bar
    },

    group_overrides = {
      ["@tag.builtin.javascript"] = { fg = "#679ad1" },
      ["@tag.javascript"] = { fg = "#4ec9b0" },
      ["@tag.attribute.javascript"] = { fg = "#dcdcaf" },
      ["@type.javascript"] = { fg = "#4ec9b0" },

      NeoTreeFileName = { fg = "#cccccc" },
      NeoTreeDirectoryName = { fg = "#cccccc" },
      NeoTreeRootName = { bold = true },

      BlinkCmpMenu = { bg = "#1e1e1e" },
      BlinkCmpMenuBorder = { fg = "#454545" },
      BlinkCmpDoc = { bg = "#1e1e1e" },
      BlinkCmpDocBorder = { fg = "#454545" },

      LspInlayHint = { fg = "#969696", bg = "NONE", italic = true },

      NeoTreeGitIgnored = { fg = "#8c8c8c" },
      NeoTreeGitUntracked = { fg = "#6e9d78" },
      NeoTreeGitModified = { fg = "#dcc193" },

      -- Apply VS Code window backgrounds
      Normal = { bg = "#1e1e1e" }, -- Main editor
      NormalNC = { bg = "#181818" }, -- Inactive windows (slightly darker)
      NormalFloat = { bg = "#252526", fg = "#cccccc" }, -- Popups/floating windows
      FloatBorder = { fg = "#454545", bg = "#252526" }, -- Popup borders

      -- VS Code specific window styling
      SnacksDashboardNormal = { bg = "#1e1e1e" }, -- Dashboard uses main editor bg
      SnacksNotifierInfo = { bg = "#252526" }, -- Notifications use sidebar bg
      SnacksInputNormal = { bg = "#3c3c3c" }, -- Input uses VS Code input bg

      -- Sidebar elements
      NeoTreeNormal = { bg = "#252526" }, -- File explorer
      NeoTreeNormalNC = { bg = "#1a1a1a" }, -- Inactive explorer

      -- Status and tab bars
      StatusLine = { bg = "#007acc", fg = "#ffffff" }, -- Active status
      StatusLineNC = { bg = "#2d2d30", fg = "#cccccc" }, -- Inactive status
      TabLine = { bg = "#2d2d30", fg = "#cccccc" }, -- Inactive tabs
      TabLineFill = { bg = "#1e1e1e" }, -- Tab bar fill
      TabLineSel = { bg = "#1e1e1e", fg = "#ffffff" }, -- Active tab
    },
  },
  config = function(_, opts)
    require("vscode").setup(opts)
    vim.cmd.colorscheme("vscode")
    require("utils").fn.sethl(0, "SnacksNormal", { link = "Normal" })
  end,
}
