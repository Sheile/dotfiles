return {
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig'
    },
    opts = {
      ensure_installed = {
        -- 'bashls',
        -- 'cssls',
        -- 'dockerls',
        -- 'docker_compose_language_service',
        -- 'html',
        -- 'jsonls',
        'lua_ls',
        -- 'marksman',
        -- 'nginx_language_server',
        -- 'pylsp',
        -- 'tailwindcss',
        'ts_ls',
        -- 'yamlls',
      }
    },
  },
}
