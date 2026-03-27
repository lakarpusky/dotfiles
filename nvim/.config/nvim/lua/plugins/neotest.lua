-- --------
-- source: https://github.com/nvim-neotest/neotest
-- --------------------------------------------------------
-- Testing framework integration for running tests inline
-- with support for Jest, Vitest, and Playwright
--
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- Adapters for JavaScript/TypeScript testing
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
    "thenbe/neotest-playwright",
    -- Python
    "nvim-neotest/neotest-python",
  },
  keys = {
    -- stylua: ignore start
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run nearest test" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
    { "<leader>ta", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Run all tests" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
    { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show test output" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
    { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Watch file tests" },
    { "[n", function() require("neotest").jump.prev({ status = "failed" }) end, desc = "Previous failed test" },
    { "]n", function() require("neotest").jump.next({ status = "failed" }) end, desc = "Next failed test" },
    -- stylua: ignore start
  },
  config = function()
    require("neotest-python")({ dap = { justMyCode = false }, runner = "pytest" })
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.js",
          env = { CI = true },
          -- stylua: ignore
          cwd = function() return vim.fn.getcwd() end,
        }),
        require("neotest-vitest"),
        require("neotest-playwright").adapter({
          options = { persist_project_selection = true, enable_dynamic_test_discovery = true },
        }),
      },
      icons = { passed = "✓", running = "●", failed = "✗", skipped = "○", unknown = "?" },
      floating = { border = "rounded", max_height = 0.6, max_width = 0.6 },
      summary = { open = "botright vsplit | vertical resize 50" },
    })
  end,
}
