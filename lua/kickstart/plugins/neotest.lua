local M = {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neotest/nvim-nio',
      'nvim-treesitter/nvim-treesitter',
      'jfpedroza/neotest-elixir',
      'nvim-neotest/neotest-jest',
      'marilari88/neotest-vitest',
      'thenbe/neotest-playwright',
      'GustavEikaas/easy-dotnet.nvim',
    },
    keys = {
      {
        '<leader>tr',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run Nearest Test',
      },
      {
        '<leader>tf',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = 'Run File',
      },
      {
        '<leader>ta',
        function()
          require('neotest').run.run(vim.uv.cwd())
        end,
        desc = 'Run All Tests',
      },
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle Summary',
      },
      {
        '<leader>to',
        function()
          require('neotest').output.open { enter = true }
        end,
        desc = 'Show Output',
      },
      {
        '<leader>tS',
        function()
          require('neotest').run.stop()
        end,
        desc = 'Stop',
      },
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-elixir',
          require 'neotest-jest',
          require 'neotest-vitest' {
            filter_dir = function(name, _, _)
              return name ~= 'node_modules'
            end,
          },
          require('neotest-playwright').adapter {
            options = {
              persist_project_selection = true,
            },
          },
          require 'easy-dotnet.neotest',
        },
      }
    end,
  },
}

return M
-- vim: ts=2 sts=2 sw=2 et
