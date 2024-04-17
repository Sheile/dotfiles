return {
  {
    'tyru/caw.vim',
    keys = {
      { '<Leader>c', '<Plug>(caw:hatpos:toggle)', mode = {'n', 'v'} }
    }
  },
  'github/copilot.vim',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function ()
      local configs = require('nvim-treesitter.configs')
      configs.setup({
        ensure_installed = {
          'c', 'lua', 'vim', 'vimdoc', 'query', 'bash', 'javascript', 'html', 'css', 'csv',
          'git_config', 'git_rebase', 'gitcommit', 'gitignore', 'json', 'markdown_inline',
          'perl', 'php', 'python', 'requirements', 'ruby', 'rust', 'scss', 'sql',
          'ssh_config', 'tmux', 'toml', 'typescript', 'xml', 'yaml'
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('nightfox').setup({
        groups = {
          all = {
            WinSeparator = { fg = 'fg3' }
          }
        }
      })
      vim.cmd([[colorscheme nightfox]])
    end
  },
  'nvim-tree/nvim-web-devicons',
}
