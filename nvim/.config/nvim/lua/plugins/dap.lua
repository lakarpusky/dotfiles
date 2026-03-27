-- About:
-- ------
-- source:
-- -------
--
--
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui", -- UI for sessions, scopes, breakpoints
    "nvim-neotest/nvim-nio", -- Async lib for UI
    "theHamsta/nvim-dap-virtual-text", -- Inline variable previews (like VSCode)
    "jay-babu/mason-nvim-dap.nvim", -- Bridges Mason to DAP adapters
    "mxsdev/nvim-dap-vscode-js", -- JS-specific wrapper for the adapter
  },
  config = function()
    local dap, dapui, dap_vt = require("dap"), require("dapui"), require("nvim-dap-virtual-text")

    -- Setup UI and virtual text
    dapui.setup() -- Default layout: sidebar for scopes, stacks, watches
    dap_vt.setup({ commented = true }) -- Show values as comments for non-intrusive view

    -- Auto-open/close UI on sessions (integrates with dropbar/breadcrumbs)
    -- stylua: ignore start
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
    -- stylua: ignore end

    -- Adapter setup for JS/TS (using the Mason-installed js-debug-adapter)
    require("dap-vscode-js").setup({
      debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
      adapters = { "pwa-node", "pwa-chrome" }, -- pwa-node for server, pwa-chrome for browser/React client
    })

    -- Configurations fro JS/TS/React
    local js_languages = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
    for _, lang in ipairs(js_languages) do
      dap.configurations[lang] = {
        -- Client-side: Debug React/JSX in browser (Umi dev servers)
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch Chrome for React",
          url = "http://localhost:8000", -- Default Umi dev port
          webRoot = "${workspaceFolder}/src",
          sourceMaps = true,
          protocol = "inspector",
          skipFiles = {
            "**/node_modules/**",
            "node_modules/**",
            "**/@umijs/**",
            "**/umi/**",
            "**/umi-production/**",
          },
          sourceMapPathOverrides = {
            ["webpack:///./~/*"] = "${webRoot}/*", -- Umi/Webpack source map mapping
            ["webpack:///./*.less"] = "${webRoot}/*.less", -- Map Less Files
          },
        },
        -- Server-side: Debug Node processes (e.g., Dva effects or Umi server plugins)
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Node File (Dva/Umi)",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "node", -- Or "tsx" if using TS directly (npm i -g tsx)
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal", -- Output in Neovim split, fine with Tmux
          skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to Node Process (Dva Effects)",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = { "<node_modules>/**", "node_modules/**" },
        },
      }
    end

    -- Optional: Custom breakpoint sign (integrates with gitsigns/icons)
    vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
  end,
}
