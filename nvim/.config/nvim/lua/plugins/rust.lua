return {
  {
    "mrcjkb/rustaceanvim",
    version = "^9",
    lazy = false,
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            require("utils").lsp.on_attach(client, bufnr)

            vim.keymap.set("n", "<leader>cR", function()
              vim.cmd.RustLsp("codeAction")
            end, { desc = "Rust Code Action", buffer = bufnr })

            vim.keymap.set("n", "<leader>rr", function()
              vim.cmd.RustLsp("runnables")
            end, { desc = "Runnables", buffer = bufnr })
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = { enable = true },
              },
              checkOnSave = true,
              procMacro = { enable = true },
              files = {
                excludeDirs = { ".git", "target", "node_modules" },
              },
            },
          },
        },
      }
    end,
  },

  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup({
        completion = { crates = { enabled = true } },
        lsp = { enabled = true, actions = true, completion = true, hover = true },
      })
    end,
  },
}
