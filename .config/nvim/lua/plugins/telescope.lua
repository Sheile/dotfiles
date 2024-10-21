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
        fzf = {
          fuzzy = false,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
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
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    config = function ()
      require('telescope').load_extension('fzf')
    end
  },
}
