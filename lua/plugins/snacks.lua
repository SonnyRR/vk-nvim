local M = {
  'folke/snacks.nvim',
  lazy = false,
  opts = {
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = [[
__   ___  __
\ \ / | |/ /
 \ V /| ' <
  \_/ |_|\_\

        ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = "󱥒 ",  key = "m", desc = "Mason", action = ":Mason" },
          { icon = "♥︎ ",  key = "h", desc = "Health Check", action = ":checkhealth" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    quickfile = {},
    lazygit = {},
  },
  keys = {
    {
      '<leader>lg',
      function()
        Snacks.lazygit()
      end,
      desc = 'LazyGit',
    },
  },
}

return M
-- vim: ts=2 sts=2 sw=2 et
