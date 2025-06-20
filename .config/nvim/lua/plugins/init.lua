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
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      separator = '-',
    },
  },
  {
    'petertriho/nvim-scrollbar',
    opts = {
      handle = {
        color = '#7A8CA3',
      }
    },
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
            Whitespace = { link = 'Comment' }
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
      -- Add some characters to handle as double width
      vim.g.ambiwidth_add_list = {
        { 0x00d7, 0x00d7, 2 }, -- ×
        { 0x25b3, 0x25b3, 2 }, -- △
      }
      -- Fix width of web-dev-icons in telescope
      vim.g.ambiwidth_cica_enabled = false
    end
  },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      indent = {
        enable = true,
        chars = { '│' },
        style = { '#A83939', '#A86E39', '#A8A839', '#39A839', '#39A8A8', '#3939A8', '#7439A8' },
      }
    },
    keys = {
      { '<Leader>pi', function()
        local enabled, _ = pcall(vim.api.nvim_get_autocmds, { group = 'hlchunk_indent' })
        if enabled then
          vim.cmd('DisableHLIndent')
        else
          vim.cmd('EnableHLIndent')
        end
      end , mode = 'n' },
    }
  },
  {
    'monaqa/dial.nvim',
    keys = {
      { '<C-a>', function() require('dial.map').manipulate('increment', 'normal') end, mode = 'n' },
      { '<C-x>', function() require('dial.map').manipulate('decrement', 'normal') end, mode = 'n' },
    }
  }
}
