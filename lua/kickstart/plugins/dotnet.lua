local M = {
  {
    'GustavEikaas/easy-dotnet.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('easy-dotnet').setup {
        debugger = {
          bin_path = (function()
            local is_windows = vim.uv.os_uname().sysname == 'Windows_NT'
            local debugger_bin = is_windows and 'netcoredbg.cmd' or 'netcoredbg'
            return vim.fs.joinpath(vim.fn.stdpath 'data', 'mason', 'bin', debugger_bin)
          end)(),
        },
        -- Uncomment in case you need to debug issues.
        -- server = {
        --   log_level = 'Verbose',
        -- },
      }
    end,
  },
}

return M
-- vim: ts=2 sts=2 sw=2 et
