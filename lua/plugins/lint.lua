-- Clear the diagnostics produced by nvim-lint for a buffer, leaving any LSP
-- diagnostics in place. Resetting per linter namespace keeps this scoped to
-- what the linters actually own.
local function clear_lint_diagnostics(bufnr)
  local lint = require 'lint'
  for _, name in ipairs(lint.linters_by_ft[vim.bo[bufnr].filetype] or {}) do
    vim.diagnostic.reset(lint.get_namespace(name), bufnr)
  end
end

local M = {
  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      {
        '<leader>tl',
        function()
          -- Flip away from the enabled default, so the first press on a fresh
          -- buffer turns linting off rather than on (`not nil` is `true`).
          vim.b.lint_enabled = vim.b.lint_enabled == false
          if vim.b.lint_enabled then
            require('lint').try_lint()
          else
            clear_lint_diagnostics(0)
          end
          vim.notify(('Lint %s'):format(vim.b.lint_enabled and 'ON' or 'OFF'))
        end,
        desc = '[T]oggle [L]int for this buffer',
      },
    },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint-cli2' },
        dockerfile = { 'hadolint' },
        json = { 'jsonlint' },
        yaml = { 'yamllint' },
        text = { 'vale' },
      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Respect the per-buffer opt-out set by <leader>tl. Compared against
          -- `false` explicitly, so the nil default keeps linting enabled.
          if vim.b.lint_enabled == false then
            clear_lint_diagnostics(0)
            return
          end
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}

return M
-- vim: ts=2 sts=2 sw=2 et
