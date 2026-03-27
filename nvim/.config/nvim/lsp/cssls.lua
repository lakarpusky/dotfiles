return {
  settings = {
    css = { lint = { emptyRules = "ignore" } },
    scss = {
      lint = { emptyRules = "ignore" },
      completion = {
        -- Auto-add semicolons and trigger value completions for better DX
        completePropertyWithSemicolon = true,
        triggerPropertyValueCompletion = true,
      },
    },
    less = {
      lint = { emptyRules = "ignore" },
      completion = {
        completePropertyWithSemicolon = true,
        triggerPropertyValueCompletion = true,
      },
    },
  },
}
