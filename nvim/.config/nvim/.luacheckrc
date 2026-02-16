globals = {
  "vim",
  "package",
  "Snacks",
  "MiniIcons",
}

read_globals = {
  "vim",
  "package",
}

ignore = {
  "212", -- Unused argument
  "213", -- Unused loop variable
}

files["lua/"] = {
  globals = { "vim" },
}
