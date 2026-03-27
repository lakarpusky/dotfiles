-- --------
-- source: https://github.com/nvim-neo-tree/neo-tree.nvim
-- --------------------------------------------------------
-- A modern file explorer for Neovim with support for multiple sources,
-- customizable UI, and performance optimizations.
--
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {},
  config = function()
    -- Disable netrw early to avoid conflicts
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local neo_tree = require("neo-tree")

    neo_tree.setup({
      close_if_last_window = false,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
      open_files_using_relative_paths = false,
      sort_case_insensitive = false,
      default_component_configs = {
        indent = {
          indent_size = 2,
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
          padding = 1,
        },
        modified = { symbol = "[+]", highlight = "NeoTreeModified" },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
        },
        git_status = {
          symbols = {
            added = "",
            modified = "M",
            deleted = "D",
            renamed = "R",
            untracked = "U",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "C",
          },
        },
        file_size = { enabled = false },
        type = { enabled = false },
        last_modified = { enabled = false },
        created = { enabled = false },
        symlink_target = { enabled = false },
      },
      window = {
        width = 50,
        mappings = {
          ["<2-LeftMouse>"] = "open",
          ["<cr>"] = "open",
          ["o"] = "open",
          ["<C-t>"] = "open_tabnew",
          ["."] = "set_root",
          ["a"] = { "add", config = { show_path = "none" } },
          ["A"] = "add_directory",
          ["d"] = "delete",
          ["r"] = "rename",
          ["c"] = "copy",
          ["?"] = "show_help",
          ["m"] = "move",
          ["P"] = { "toggle_preview", config = { use_float = true } },
        },
      },
      nesting_rules = {},
      filesystem = {
        follow_current_file = { enabled = true, leave_dirs_open = true },
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          never_show = {
            ".git",
            "node_modules",
            ".cache",
            "dist",
            "build",
            ".DS_Store",
            "thumbs.db",
            ".umi",
          },
          always_show = { ".gitignore", ".env" },
        },
      },
      buffers = {
        follow_current_file = { enabled = true },
        group_empty_dirs = true,
      },
      git_status = {
        window = { position = "float" },
        update_on_cursor_hold = true,
        debounce_delay = 50,
      },
      sort_function = function(a, b)
        -- Handle nil cases
        if not a.path or not b.path then
          return false
        end

        -- Extract names from paths
        local a_name = vim.fn.fnamemodify(a.path, ":t")
        local b_name = vim.fn.fnamemodify(b.path, ":t")

        -- Directories first
        if a.type == "directory" and b.type ~= "directory" then
          return true
        elseif b.type == "directory" and a.type ~= "directory" then
          return false
        end

        -- Lowercase first, then uppercase
        local a_lower = a_name:lower()
        local b_lower = b_name:lower()

        if a_lower == b_lower then
          return a_name > b_name
        end

        return a_lower < b_lower
      end,
    })

    vim.cmd([[
      highlight NeoTreeIndentMarker guifg=#1e1e2e ctermfg=235
    ]])
  end,
}
