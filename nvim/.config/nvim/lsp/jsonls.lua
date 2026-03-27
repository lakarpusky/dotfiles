local ok, schemastore = pcall(require, "schemastore")
return {
  settings = {
    json = {
      schemas = ok and schemastore.json.schemas() or {},
      -- Why the option is recommended
      -- https://github.com/b0o/SchemaStore.nvim/issues/8
      validate = { enable = true },
    },
  },
}
