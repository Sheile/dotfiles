return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
    keys = {
      { '<Leader>j', '<Cmd>Telescope buffers<CR>', mode = 'n' },
      { '<Leader>r', '<Cmd>Telescope resume<CR>', mode = 'n' },
      { '<Leader>/', function()
        local term = vim.fn.input('Search term: ')
        if term ~= '' then
          require('telescope.builtin').grep_string({search = term})
        end
      end, mode = 'n' },
      { '<Leader>b', '<Cmd>Telescope current_buffer_fuzzy_find<CR>', mode = 'n' },
      { '+', '<Cmd>Telescope grep_string<CR>', mode = { 'n', 'v' } },
      { '<Plug>(lsp)e', '<Cmd>Telescope diagnostics<CR>', mode = 'n' },
      { '<Plug>(lsp)d', '<Cmd>Telescope lsp_definitions<CR>', mode = 'n' },
      { '<Plug>(lsp)t', '<Cmd>Telescope lsp_type_definitions<CR>', mode = 'n' },
      { '<Plug>(lsp)D', '<Cmd>Telescope lsp_references<CR>', mode = 'n' },
    },
    config = function()
      require('telescope').setup({
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
      })
    end,
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
