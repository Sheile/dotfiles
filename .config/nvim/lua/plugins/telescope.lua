return {
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
    keys = {
      { '<Leader>j', '<Cmd>Telescope buffers<CR>', mode = 'n' },
      { '<Leader>r', '<Cmd>Telescope resume<CR>', mode = 'n' },
      { '<Leader>/', '<Cmd>Telescope live_grep<CR>', mode = 'n' },
      { '+', '<Cmd>Telescope grep_string<CR>', mode = { 'n', 'v' } },
    },
    opts = {
      defaults = {
        generic_sorter = require('telescope.sorters').get_substr_matcher,
        file_sorter = require('telescope.sorters').get_substr_matcher,
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
          }
        },
        mappings = {
          n = { ['q'] = 'close' },
        }
      },
      pickers = {
        buffers = {
          sort_mru = true,
        }
      },
      extensions = {
        file_browser = {
          hidden = true,
          hide_parent_dir = true,
          prompt_path = true,
        }
      }
    },
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    keys = {
      { '<Leader>f', '<Cmd>Telescope file_browser<CR>', mode = 'n' },
      { '<Leader>D', '<Cmd>Telescope file_browser path=%:p:h<CR>', mode = 'n' }
    }
  },
}
