local M = {
  {
    'GustavEikaas/easy-dotnet.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('easy-dotnet').setup {
        -- NetCoreDbg is now available OOB w/ zero click configuration in easy-dotnet.
        -- However, I will continue to manage it through Mason.
        debugger = {
          bin_path = (function()
            local is_windows = vim.uv.os_uname().sysname == 'Windows_NT'
            local debugger_bin = is_windows and 'netcoredbg.cmd' or 'netcoredbg'
            return vim.fs.joinpath(vim.fn.stdpath 'data', 'mason', 'bin', debugger_bin)
          end)(),
        },
        managed_terminal = {
          auto_hide = true,
          auto_hide_delay = 2000,
        },
        -- https://github.com/GustavEikaas/easy-dotnet.nvim/blob/main/lua/easy-dotnet/options.lua
        lsp = {
          enabled = false,
          roslynator_enabled = true,
          analyzer_assemblies = {},
          -- Disable codelens until the indentation for the symbols is fixed by the neovim team.
          -- for reference see:
          --  https://github.com/GustavEikaas/easy-dotnet.nvim/issues/940
          --  https://github.com/neovim/neovim/issues/38676
          auto_refresh_codelens = false,
          enhanced_rename = true,
          easy_dotnet_extension_enabled = true,
          restart_roslyn_on_branch_change = true,
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
        test_runner = {
          neotest_integration = true,
        },
        picker = 'telescope',
        -- Uncomment in case you need to debug issues.
        -- server = {
        --   log_level = 'Verbose',
        -- },
      }

      -- Visual Studio style mappings.
      -- https://github.com/GustavEikaas/easy-dotnet.nvim/blob/main/docs/advanced-patterns.md

      -- Ctrl+B -> Build. Unlike `build_default`, this opens a picker so the target
      -- project/solution can be chosen on every build. Use `:Dotnet build default`
      -- (or `build_default_quickfix`) if you want the persisted default instead.
      vim.keymap.set('n', '<C-b>', function()
        require('easy-dotnet').build()
      end, { desc = 'Build (.NET)', nowait = true })

      -- Alt+I -> Toggle the managed terminal panel. Mapped in terminal mode as well so
      -- the panel can be hidden without leaving it. Note the panel is separate from
      -- `external_terminal` (where `:Dotnet run` output goes).
      vim.keymap.set({ 'n', 't' }, '<A-i>', function()
        vim.cmd 'Dotnet terminal toggle'
      end, { desc = 'Toggle .NET terminal', noremap = true, silent = true })

      -- Ctrl+P -> Run the persisted default project with its default launch profile.
      vim.keymap.set('n', '<C-p>', function()
        vim.cmd 'Dotnet run profile default'
      end, { desc = 'Run .NET (default profile)', nowait = true })

      -- Ctrl+Alt+P -> Debug the persisted default project with its default launch profile.
      vim.keymap.set('n', '<C-A-p>', function()
        vim.cmd 'Dotnet debug profile default'
      end, { desc = 'Debug .NET (default profile)', nowait = true })
    end,
  },
}

return M
-- vim: ts=2 sts=2 sw=2 et
