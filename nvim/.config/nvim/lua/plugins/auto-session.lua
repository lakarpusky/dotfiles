-- -------
-- source: https://github.com/rmagatti/auto-session
-- -------------------------------------------------
-- To save and restore the workspace state easyly.
--
return {
  "rmagatti/auto-session",
  opts = { bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" } },
  config = function()
    require("auto-session").setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
    })
    -- docs: recommended session config for the best experience
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
  end,
  keys = {
    { "<leader>ws", "<cmd>AutoSession save<cr>", desc = "Save session" },
    { "<leader>wr", "<cmd>AutoSession restore<cr>", desc = "Restore session" },
  },
}
