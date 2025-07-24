return {
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig'
    },
    lazy = false,
    opts = {
      ensure_installed = {
        'bashls',
        -- 'cssls',
        -- 'dockerls',
        -- 'docker_compose_language_service',
        -- 'html',
        'jsonls',
        'lua_ls',
        -- 'marksman',
        -- 'nginx_language_server',
        'pylsp',
        -- 'tailwindcss',
        'ts_ls',
        'yamlls',
        'eslint',
      }
    },
    keys = {
      { '<Leader>l', '<Plug>(lsp)', mode = 'n' },
      { '<Plug>(lsp)f', vim.lsp.buf.format, mode = 'n' },
      { '<Plug>(lsp)r', vim.lsp.buf.rename, mode = 'n' },
      { 'g[', vim.diagnostic.goto_prev, mode = 'n' },
      { 'g]', vim.diagnostic.goto_next, mode = 'n' },
    },
  },
  {
    'ray-x/lsp_signature.nvim',
    event = 'InsertEnter',
    config = function()
      require('lsp_signature').setup({
        hint_prefix = {
          above = '↙ ',
          current = '← ',
          below = '↖ '
        },
      })
      -- Explicitly set highlight which is defined in lsp_signature.
      -- because LspAttach event was already emitted due to lazy load for lsp_signature.
      vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { link = 'Search' })
    end,
    keys = {
      { '<C-k>', function() require('lsp_signature').toggle_float_win() end, mode = { 'i', 'n' } },
    },
  }
}
