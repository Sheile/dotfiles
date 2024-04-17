return {
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
    keys = {
      { '<Leader>j', '<Cmd>Telescope buffers<CR>', mode = 'n' }
    },
    opts = {
      defaults = {
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
      extensions = {
        file_browser = {
          hidden = true,
          hide_parent_dir = true
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
  }
}
