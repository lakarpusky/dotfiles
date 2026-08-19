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

      -- Register parsers for filetypes whose names differ from the parser name.
      vim.treesitter.language.register("javascript", { "javascriptreact" })
      vim.treesitter.language.register("tsx", { "typescriptreact" })
      vim.treesitter.language.register("markdown", { "markdown_inline" })
      vim.treesitter.language.register("bash", { "zsh" })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "editorconfig",
          "git_config",
          "gitcommit",
          "gitignore",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
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
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
