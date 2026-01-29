local M = {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      local languages = {
        'diff',
        'lua',
        'markdown',
        'luadoc',
        'regex',
        'json',
        'editorconfig',
        'git_rebase',
        'git_config',
        'gitcommit',
        'gitignore',
        'gitattributes',
        'dockerfile',
        'powershell',
        'bash',
        'c_sharp',
        'sql',
        'javascript',
        'typescript',
        'html',
        'angular',
        'css',
        'scss',
        'zig',
        'elixir',
        'xml',
        'yaml',
      }

      if vim.loop.os_uname().sysname == 'Windows_NT' then
        -- On Windows NT systems, make sure you install GCC from WinLibs.com
        -- Zig no longer works for all parsers, since 'nvim-treesitter'
        -- refactored the plugin and moved from the 'master' to te 'main' branch
        vim.env.CC = 'gcc'
      end
      require('nvim-treesitter').install(languages)

      local filetypes = {}
      for _, lang in ipairs(languages) do
        for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
          table.insert(filetypes, ft)
        end
      end

      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}
return M
-- vim: ts=2 sts=2 sw=2 et
