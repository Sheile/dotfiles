return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        matching = {
          disallow_fuzzy_matching = true,
          disallow_partial_matching = true,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path', { trailing_slash = true } },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping(function(fallback)
            -- Complete by nvim_lsp only if complete after dot.
            local col = vim.fn.col('.') - 1
            local prev_char = string.sub(vim.fn.getline('.'), col, col)
            local option = {}
            if prev_char == '.' then
              option = { config = { sources = { { name = 'nvim_lsp' } } } }
            end
            if not cmp.complete(option) then
              fallback()
            end
          end),
          ['<Tab>'] = cmp.mapping.confirm { select = true },
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<C-CR>'] = cmp.mapping.confirm { select = true },
          ['<NL>'] = cmp.mapping.confirm { select = true },  -- Ctrl + Enter in terminal
        }),
        experimental = {
          ghost_text = true,
        },
      })
    end
  },
}
