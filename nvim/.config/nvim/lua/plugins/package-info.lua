-- -------
-- source: https://github.com/vuki656/package-info.nvim
-- ------------------------------------------------------
-- To manage dependencies from package.json file
--
return {
  "vuki656/package-info.nvim",
  event = "BufEnter package.json",
  ft = "json",
  dependencies = "MunifTanjim/nui.nvim",
  opts = {
    colors = { up_to_date = "#3C4048", outdated = "#fc514e" },
    icons = { enable = true, style = { outdated = "  ", up_to_date = "  " } },
    autostart = true, -- When `package.json` is opened
    hide_up_to_date = true,
    hide_unstable_versions = true,
    package_manager = "yarn",
  },
}
