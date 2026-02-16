-- -------
-- source: https://github.com/sindrets/diffview.nvim
-- --------------------------------------------------
-- To easily cycling through diffs for any git rev
--
return {
  "sindrets/diffview.nvim",
  lazy = true,
  cmd = { "DiffviewOpen", "DiffviewClose" },
  keys = {
    {
      "<leader>dv",
      function()
        -- stylua: ignore start
        if next(require("diffview.lib").views) == nil then vim.cmd("DiffviewOpen")
        else vim.cmd("DiffviewClose") end
        -- stylua: ignore end
      end,
      desc = "Git diff",
    },
  },
  config = function()
    require("diffview").setup({
      view = { file_history = { layout = "diff2_vertical" } },
      default_args = { DiffviewFileHistory = { "--max-count=100" } },
      keymaps = {
        file_panel = {
          { "n", "cc", "<Cmd>Git commit <bar> wincmd K<CR>", { desc = "Commit staged changes" } },
        },
      },
    })
  end,
}
