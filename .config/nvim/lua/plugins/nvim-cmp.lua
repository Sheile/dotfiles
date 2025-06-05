return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_vscode').lazy_load({ paths = { GetXdgConfigHome() ..'/nvim/snippets' } })

      cmp.setup({
        matching = {
          disallow_fuzzy_matching = true,
          disallow_partial_matching = true,
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path', { trailing_slash = true } },
          { name = 'luasnip' },
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

          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                  luasnip.expand()
              else
                  cmp.confirm({ select = true })
              end
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        experimental = {
          ghost_text = true,
        },
      })
    end
  },
}
