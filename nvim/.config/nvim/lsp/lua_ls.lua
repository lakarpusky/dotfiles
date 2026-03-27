return {
  settings = {
    codeLens = { enable = true },
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = { enable = false },
      completion = { callSnippet = "Replace" },
      format = { enable = false },
      diagnostics = {
        globals = { "vim", "package" },
      },
    },
  },
}
