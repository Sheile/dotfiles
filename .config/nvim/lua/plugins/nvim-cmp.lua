return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        sources = {
          { name = 'buffer' },
          { name = 'path', { trailing_slash = true } },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
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
