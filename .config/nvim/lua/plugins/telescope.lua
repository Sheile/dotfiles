local default_vimgrep_arguments = {
  'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', -- Telescope defaults
  '--hidden', -- include hidden files
  '--glob', '!**/.git/*', -- exclude .git directory
}

return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
    keys = {
      { '<Leader>j', '<Cmd>Telescope buffers<CR>', mode = 'n' },
      { '<Leader>r', '<Cmd>Telescope resume<CR>', mode = 'n' },
      { '<Leader>/', function()
        vim.ui.input({ prompt = 'Search term: ' }, function(term)
          if term ~= nil and term ~= '' then
            require('telescope.builtin').grep_string({search = term})
          end
        end)
      end, mode = 'n' },
      { '<Leader>b', '<Cmd>Telescope current_buffer_fuzzy_find<CR>', mode = 'n' },
      { '+', function()
        local word
        local vimgrep_arguments = vim.list_extend({}, default_vimgrep_arguments)
        if vim.fn.mode() == 'v' or vim.fn.mode() == 'V' then
          -- Visual mode: grep selected text
          local start_pos = vim.fn.getpos('v')
          local end_pos = vim.fn.getpos('.')
          word = table.concat(vim.fn.getregion(start_pos, end_pos))
        else
          -- Normal mode: grep word under cursor with word boundary for exact word search
          word = vim.fn.expand('<cword>')
          table.insert(vimgrep_arguments, '--word-regexp')
        end
        require('telescope.builtin').grep_string({
          search = word,
          vimgrep_arguments = vimgrep_arguments
        })
      end, mode = { 'n', 'v' } },
      { '<Plug>(lsp)e', '<Cmd>Telescope diagnostics<CR>', mode = 'n' },
      { '<Plug>(lsp)d', '<Cmd>Telescope lsp_definitions<CR>', mode = 'n' },
      { '<Plug>(lsp)t', '<Cmd>Telescope lsp_type_definitions<CR>', mode = 'n' },
      { '<Plug>(lsp)D', '<Cmd>Telescope lsp_references<CR>', mode = 'n' },
      { 'gd', '<Cmd>Telescope lsp_definitions<CR>', mode = 'n' },
      { 'gD', '<Cmd>Telescope lsp_references<CR>', mode = 'n' },
    },
    config = function()
      local get_sorter = require('plugins/telescope/sorter')
      require('telescope').setup({
        defaults = {
          generic_sorter = get_sorter,
          file_sorter = get_sorter,
          sorting_strategy = 'ascending',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
            }
          },
          vimgrep_arguments = vimgrep_arguments,
          mappings = {
            n = { ['q'] = 'close' },
            i = { ['<esc>'] = 'close' },
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
            respect_gitignore = false,
            hide_parent_dir = true,
            prompt_path = true,
            create_from_prompt = false,
            follow_symlinks = true,
            mappings = {
              ['i'] = {
                ['~'] = function(prompt_bufnr)
                  local fb_actions = require('telescope').extensions.file_browser.actions
                  fb_actions.goto_home_dir(prompt_bufnr)
                end,
                ['/'] = function(prompt_bufnr)
                  local fb_actions = require('telescope').extensions.file_browser.actions
                  local prompt = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, 1, false)[1]
                  if prompt == './' then
                    fb_actions.open_dir(prompt_bufnr, nil, '/')
                  else
                    fb_actions.path_separator(prompt_bufnr)
                  end
                end,
                -- Ctrl + CR in SSH terminal
                ['<NL>'] = function(prompt_bufnr)
                  local fb_actions = require('telescope').extensions.file_browser.actions
                  fb_actions.create_from_prompt(prompt_bufnr)
                end,
              },
            }
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
