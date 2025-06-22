local M = {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim', -- UI components
      'rcarriga/nvim-notify', -- Notification backend
    },
    config = function()
      require('notify').setup {
        stages = 'fade_in_slide_out',
        timeout = 3000,
        render = 'default',
      }

      vim.notify = require 'notify'

      require('noice').setup {
        lsp = {
          progress = {
            enabled = true,
          },
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },
        },
        presets = {
          bottom_search = false, -- Use a classic bottom cmdline for search
          command_palette = false, -- Command palette style UI
          long_message_to_split = true, -- Redirect long messages to a split
          inc_rename = false, -- Needs `inc-rename.nvim`
          lsp_doc_border = true, -- Add borders to hover/signature popups
        },
        views = {
          notify = {
            replace = true,
            merge = true,
          },
        },
      }
    end,
  },
}

return M
-- vim: ts=2 sts=2 sw=2 et
