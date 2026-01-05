local M = {
  {
    'GustavEikaas/easy-dotnet.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('easy-dotnet').setup {
        -- NetCoreDbg is now available OOB w/ zero click configuration in easy-dotnet.
        -- However, I will continue to manage it through Mason, since I want a more trusted
        -- source for it.
        debugger = {
          bin_path = (function()
            local is_windows = vim.uv.os_uname().sysname == 'Windows_NT'
            local debugger_bin = is_windows and 'netcoredbg.cmd' or 'netcoredbg'
            return vim.fs.joinpath(vim.fn.stdpath 'data', 'mason', 'bin', debugger_bin)
          end)(),
        },
        -- https://github.com/GustavEikaas/easy-dotnet.nvim/blob/main/lua/easy-dotnet/options.lua
        lsp = {
          enabled = true,
          roslynator_enabled = true,
          analyzer_assemblies = {},
          config = {
            settings = {
              -- https://github.com/dotnet/vscode-csharp/blob/main/test/lsptoolshost/unitTests/configurationMiddleware.test.ts
              ['csharp|inlay_hints'] = {
                csharp_enable_inlay_hints_for_implicit_object_creation = true,
                csharp_enable_inlay_hints_for_implicit_variable_types = true,
                csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                csharp_enable_inlay_hints_for_types = true,
                dotnet_enable_inlay_hints_for_indexer_parameters = true,
                dotnet_enable_inlay_hints_for_literal_parameters = true,
                dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                dotnet_enable_inlay_hints_for_other_parameters = true,
                dotnet_enable_inlay_hints_for_parameters = true,
                dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
              },
              ['csharp|code_lens'] = {
                dotnet_enable_references_code_lens = true,
              },
              ['csharp|formatting'] = {
                dotnet_organize_imports_on_format = true,
              },
            },
          },
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
