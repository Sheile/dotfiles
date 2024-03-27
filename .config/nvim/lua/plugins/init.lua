return {
  {
    'tyru/caw.vim',
    keys = {
      { '<Leader>c', '<Plug>(caw:hatpos:toggle)', mode = {'n', 'v'} }
    }
  },
  'github/copilot.vim',
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('nightfox').setup()
      vim.cmd([[colorscheme nightfox]])
    end
  },
}
