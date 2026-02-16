-- --------
-- source: https://github.com/folke/snacks.nvim
-- ----------------------------------------------
-- Collection of quality-of-like plugins that enhance the editor's functionallity,
-- including features like: animations, file renaming, and dashboard integration.
--
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    input = { enabled = true },
    quickfile = { enabled = true },
    words = { enabled = true },
    rename = { enabled = true },
    picker = { enabled = true },
    progress = { enabled = true },

    lsp = { enabled = false },
    scroll = { enabled = false },
    explorer = { enabled = false },

    statuscolumn = {
      enabled = true,
      left = { "mark", "sign" },
      right = { "fold", "git" },
      folds = {
        -- Always show fold markers for both open and closed folds (shows code structure)
        open = true,
        git_hl = false,
      },
      git = {
        patterns = { "GitSign", "MiniDiffSign" },
      },
    },

    dashboard = {
      enabled = true,
      width = 60,
      row = nil,
      col = nil,
      pane_gap = 4,
      preset = {
        header = [[
                                  Editing evolved

███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]],
        keys = {},
      },
      sections = {
        { pane = 1, section = "header", padding = 1 },
        { pane = 1, title = "Recent", section = "recent_files", padding = 1, limit = 10 },
        {
          pane = 1,
          title = "Projects",
          section = "projects",
          limit = 5,
          padding = 1,
          action = function(project)
            vim.cmd("cd " .. project)
            local ok, AutoSession = pcall(require, "auto-session")
            if ok then
              local restored = AutoSession.RestoreSession()
              if not restored then
                Snacks.picker.files()
              end
            else
              Snacks.picker.files()
            end
          end,
        },
        { pane = 1, section = "startup", padding = 1 },
      },
    },

    indent = {
      enabled = true,
      char = "▏",
      animate = { enabled = false },
      indent = {
        enabled = true,
        only_scope = true,
      },
      scope = {
        enabled = true,
        only_current = true,
        only_scope = true,
        hl = "SnacksIndentScope",
      },
      blank = { char = " " },
      -- Filter for buffers, turn off the indents for markdown
      filter = function(buf)
        return vim.g.snacks_indent ~= false
          and vim.b[buf].snacks_indent ~= false
          and vim.bo[buf].buftype == ""
          and vim.bo[buf].filetype ~= "markdown"
      end,
      hl = "IblIndent",
    },

    fold = {
      enabled = true,
      text = {
        -- Custom fold text without line numbers
        transform = function(virtText, lnum, endLnum, width)
          local lines = (" ... [%d lines] "):format(endLnum - lnum + 1)
          local firstLine = table.concat(vim.tbl_map(function(chunk)
            return chunk[1]
          end, virtText))
          return firstLine .. lines
        end,
      },
    },

    win = {
      border = "none",
      backdrop = 60,
      wo = {
        wrap = true,
        linebreak = true,
        cursorline = true,
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },
    },

    notifier = {
      enabled = true,
      -- timeout = 3000, -- auto-dismiss
      style = "compact",
      win = { backdrop = { transparent = true } },
    },

    toggle = {
      which_key = true,
      notify = false,
      icons = { enabled = " ", disabled = " " },
      color = { enabled = "green", disabled = "yellow" },
    },

    zen = {
      enabled = true,
      win = { width = 100 },
      minimal = true,
      toggles = { dim = false },
      show = { statusline = false, tabline = false },
    },

    styles = {
      zen = {
        width = 100,
        backdrop = { transparent = false },
        wo = {
          number = false,
          signcolumn = "no",
          cursorcolumn = false,
          relativenumber = false,
        },
      },

      notification = {
        border = require("utils.icons").borders.dashed,
        wo = {
          -- spell = false,
          -- winblend = 60,
          wrap = true,
          winhl = "Normal:SnacksNotifierInfo",
        },
      },

      documentation = {
        border = require("utils.icons").borders.dashed,
        backdrop = 60,
        height = 0.4,
        max_height = 30,
        min_height = 5,
        wo = {
          wrap = true,
          linebreak = true,
          conceallevel = 2,
          concealcursor = "n",
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
      },

      float = {
        border = require("utils.icons").borders.dashed,
        backdrop = 60,
        row = nil,
        col = nil,
        relative = "editor",
        wo = {
          wrap = true,
          linebreak = true,
        },
      },

      picker = {
        border = require("utils.icons").borders.dashed,
        backdrop = { bg = "#000000", blend = 60 },
      },

      input = {
        border = require("utils.icons").borders.dashed,
        wo = {
          winhl = "NormalFloat:Normal,FloatBorder:FloatBorder",
        },
      },
    },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
    local fn, ui = require("utils.functions"), require("utils.ui")

    fn.autocmd("ColorScheme", {
      group = fn.augroup("SnacksDashboardTheme", { clear = true }),
      callback = ui.apply_dashboard_highlights,
    })

    ui.apply_dashboard_highlights()
    -- CRITICAL: Use Treesitter for code-aware folding (not snacks.indent)
    -- Treesitter creates folds based on syntax tree (functions, classes, blocks, etc.)
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    -- foldlevel=99: All folds open by default (markers still visible)
    vim.o.foldlevel = 99
    -- Minimum 1 line to create fold marker (shows all code blocks)
    vim.o.foldminlines = 1
    vim.o.foldenable = true
    -- Fold markers:  (open),  (closed) - always visible in right statuscolumn
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    vim.o.statuscolumn = '%!v:lua.require("snacks.statuscolumn").get()'
  end,
  keys = {
    -- stylua: ignore start
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep Text" },
    { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Grep Word" },

    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Git File History" },
    { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Git Log" },

    { "<leader>p", function() Snacks.picker.projects() end, desc = "Projects" },

    { "<leader>tv", function()
      Snacks.terminal(nil, {
        win = { position = "right", width = 0.3, height = 1.0 },
        id = "claude_term",
      })
    end, desc = "Terminal right" },

    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },

    { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    -- stylua: ignore end
  },
}
