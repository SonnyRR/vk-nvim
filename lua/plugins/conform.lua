local biome_config = vim.fn.stdpath 'config' .. '/biome.json'

local M = {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters = {
        biome = {
          args = function(self, ctx)
            if self:cwd(ctx) then
              return { 'format', '--stdin-file-path', '$FILENAME' }
            end
            return {
              'format',
              '--stdin-file-path',
              '$FILENAME',
              '--config-path',
              biome_config,
            }
          end,
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'biome' },
        javascriptreact = { 'biome' },
        typescript = { 'biome' },
        typescriptreact = { 'biome' },
        html = { 'biome' },
        css = { 'biome' },
        scss = { 'biome' },
        markdown = { 'markdownlint-cli2' },
        json = { 'biome' },
        jsonc = { 'biome' },
        json5 = { 'biome' },
      },
    },
  },
}

return M
-- vim: ts=2 sts=2 sw=2 et
