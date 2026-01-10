local M = {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    dependencies = {
      'saghen/blink.compat',
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
    },
    version = '*',
    opts = {
      keymap = {
        preset = 'default',
        ['<C-n>'] = { 'select_next' },
        ['<C-p>'] = { 'select_prev' },
        ['<C-y>'] = { 'select_and_accept' },
        ['<C-Space>'] = { 'show' },
        ['<C-b>'] = { 'scroll_documentation_up' },
        ['<C-f>'] = { 'scroll_documentation_down' },
        -- ['<C-l>'] = { 'snippet_forward' },
        -- ['<C-h>'] = { 'snippet_backward' },
      },
      sources = {
        default = { 'lsp', 'path', 'easy-dotnet', 'snippets', 'buffer' },
        providers = {
          lsp = {
            name = 'lsp',
            module = 'blink.cmp.sources.lsp',
          },
          path = { name = 'path', module = 'blink.cmp.sources.path' },
          ['easy-dotnet'] = {
            name = 'easy-dotnet',
            enabled = true,
            module = 'easy-dotnet.completion.blink',
            score_offset = 10000,
            async = true,
          },
          snippets = { name = 'snippets', module = 'blink.cmp.sources.snippets' },
          buffer = { name = 'buffer', module = 'blink.cmp.sources.buffer' },
        },
      },
      snippets = {
        expand = function(snippet)
          require('luasnip').lsp_expand(snippet)
        end,
      },
      completion = {
        menu = { border = 'single', winblend = 1 },
        ghost_text = { enabled = true },
        documentation = {
          auto_show = true,
          window = {
            border = 'single',
            winblend = 1,
          },
        },
      },
      signature = {
        enabled = true,
        -- window = { show_documentation = false },
      },
    },
  },
}

return M
-- vim: ts=2 sts=2 sw=2 et
