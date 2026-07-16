local M = {
  {
    'Mofiqul/dracula.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'dracula'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}

return M
-- vim: ts=2 sts=2 sw=2 et
