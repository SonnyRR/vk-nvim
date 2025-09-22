local M = {
  {
    'GustavEikaas/easy-dotnet.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('easy-dotnet').setup {
        debugger = {
          bin_path = 'netcoredbg',
        },
      }
    end,
  },
}

return M
-- vim: ts=2 sts=2 sw=2 et
