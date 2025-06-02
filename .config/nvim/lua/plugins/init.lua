return {
  {
    'numToStr/Comment.nvim',
    opts = {
      mappings = {
        basic = false,
        extra = false
      },
    },
    keys = {
      { '<Leader>c', '<Plug>(comment_toggle_linewise_current)', mode = 'n' },
      { '<Leader>c', '<Plug>(comment_toggle_linewise_visual)', mode = 'v' }
    }
  },
  'github/copilot.vim',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
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
            WinSeparator = { fg = 'fg3' },
          }
        }
      })
      vim.cmd([[colorscheme nightfox]])
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1
          }
        }
      },
      inactive_sections = {
        lualine_c = {
          {
            'filename',
            path = 1
          }
        }
      }
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  'nvim-tree/nvim-web-devicons',
  {
    'rbtnn/vim-ambiwidth',
    init = function()
      -- Add △ to handle double width
      vim.g.ambiwidth_add_list = {{0x00d7, 0x00d7, 2}, {0x25b3, 0x25b3, 2}}
    end
  },
}
