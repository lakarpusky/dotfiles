local fn = require("utils.functions")
local M = {}

M.mode_map = {
  NORMAL = "N",
  ["O-PENDING"] = "N?",
  INSERT = "I",
  VISUAL = "V",
  ["V-BLOCK"] = "VB",
  ["V-LINE"] = "VL",
  ["V-REPLACE"] = "VR",
  REPLACE = "R",
  COMMAND = "!",
  SHELL = "SH",
  TERMINAL = "T",
  EX = "X",
  ["S-BLOCK"] = "SB",
  ["S-LINE"] = "SL",
  SELECT = "S",
  CONFIRM = "Y?",
  MORE = "M",
}

M.apply_dashboard_highlights = function()
  fn.sethl(0, "SnacksDashboardHeader", { bold = true })
  fn.sethl(0, "SnacksDashboardTitle", {})
  fn.sethl(0, "SnacksDashboardKey", { bold = true })
  fn.sethl(0, "SnacksDashboardFooter", { italic = true })
end

M.diff_source = function()
  local gitsigns = vim.b.gitsigns_status_dict
  return gitsigns and {
    added = gitsigns.added,
    modified = gitsigns.changed,
    removed = gitsigns.removed,
  } or nil
end

M.macro_recording = function()
  local reg = vim.fn.reg_recording()
  return reg ~= "" and "󰑋 " .. reg or ""
end

M.word_count = function()
  -- stylua: ignore start
  if not vim.tbl_contains({ "md", "txt", "markdown" }, vim.bo.filetype) then return "" end
  local words = vim.fn.wordcount()
  local count = words.visual_words or words.words
  if count == 1 then return "1 word" end
  return count .. " words"
end

M.git_diff = function()
  -- stylua: ignore start
  local git_status = vim.b.gitsigns_status_dict
  if not git_status then return "" end
  local parts = {}
  local output = "" .. (git_status.head or "unknown")
  if git_status.added and git_status.added > 0 then table.insert(parts, "+" .. git_status.added) end
  if git_status.changed and git_status.changed > 0 then table.insert(parts, "~" .. git_status.changed) end
  if git_status.removed and git_status.removed > 0 then table.insert(parts, "-" .. git_status.removed) end
  -- with diff stats if any
  if #parts > 0 then output = output .. " " .. table.concat(parts, " ") end
  return output
end

M.scroll_position = function()
  local icons = { "󰋙 ", "󰫃 ", "󰫄 ", "󰫅 ", "󰫆 ", "󰫇 ", "󰫈 " }
  local line, vcol = vim.fn.line("."), vim.fn.virtcol(".")
  local total = vim.api.nvim_buf_line_count(0)
  local percentage = total > 0 and ((line - 1) / total) or 0
  local idx = math.floor(percentage * (#icons - 1)) + 1
  local icon = icons[idx]
  return string.format("%d:%d %s", line, vcol, icon)
end

return M
