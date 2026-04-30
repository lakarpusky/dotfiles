-- --------
-- source: https://github.com/nvim-treesitter/nvim-treesitter
-- ------------------------------------------------------------
-- Parser generator tool that we can use to power
-- faster and more accurate syntax highlighting.
--
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      require("nvim-treesitter").install({
        "editorconfig",
        "git_config",
        "gitcommit",
        "gitignore",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "scss",
        "json",
        "jsdoc",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "vim",
        "vimdoc",
        "yaml",
        "regex",
        "comment",
        "tmux",
        "toml",
        "python",
      })

      -- Use bash parser for zsh files
      -- vim.treesitter.language.register("bash", "zsh")
      -- vim.treesitter.language.register("markdown", "markdown_inline")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "editorconfig",
          "git_config",
          "gitcommit",
          "gitignore",
          "javascript",
          "typescript",
          "tsx",
          "html",
          "css",
          "scss",
          "json",
          "jsdoc",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "vim",
          "vimdoc",
          "yaml",
          "regex",
          "comment",
          "tmux",
          "toml",
          "python",
        },
        callback = function()
          vim.treesitter.start()
          -- Folds (README "Folds")
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
          -- Indentation (README "Indentation" — flagged experimental)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
