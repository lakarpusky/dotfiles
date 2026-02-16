-- --------
-- source: https://github.com/ThePrimeagen/refactoring.nvim
-- --------------------------------------------------------
-- Refactoring library for Neovim with support for extracting
-- functions, variables, and blocks. Treesitter-powered.
--
return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    {
      "<leader>re",
      function()
        require("refactoring").refactor("Extract Function")
      end,
      mode = "x",
      desc = "Extract Function",
    },
    {
      "<leader>rf",
      function()
        require("refactoring").refactor("Extract Function To File")
      end,
      mode = "x",
      desc = "Extract Function to File",
    },
    {
      "<leader>rv",
      function()
        require("refactoring").refactor("Extract Variable")
      end,
      mode = "x",
      desc = "Extract Variable",
    },
    {
      "<leader>ri",
      function()
        require("refactoring").refactor("Inline Variable")
      end,
      mode = { "n", "x" },
      desc = "Inline Variable",
    },
    {
      "<leader>rb",
      function()
        require("refactoring").refactor("Extract Block")
      end,
      desc = "Extract Block",
    },
    {
      "<leader>rbf",
      function()
        require("refactoring").refactor("Extract Block To File")
      end,
      desc = "Extract Block To File",
    },
  },
  config = function()
    require("refactoring").setup({
      prompt_func_return_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      prompt_func_param_type = {
        go = false,
        java = false,
        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
      },
      printf_statements = {},
      print_var_statements = {},
    })
  end,
}
