vim.api.nvim_create_augroup('default', {})

-- Disable paste mode when leave
vim.api.nvim_create_autocmd('InsertLeave', {
  group = 'default',
  callback = function() vim.opt.paste = false end
})
