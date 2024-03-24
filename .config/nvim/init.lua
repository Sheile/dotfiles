vim.scriptencoding = 'utf-8'
vim.g.mapleader = ' '

-- plugins(lazy.nvim)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup('plugins')

-- general configuration
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.matchtime = 3

-- indent
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.keymap.set('n', '<Esc><Esc>', '<Cmd>noh<CR>')

-- backup/swap/undofile
vim.opt.backup = true
vim.opt.undofile = true
vim.opt.backupdir = vim.fn.expand('~/.cache') .. '/nvim/backup'
vim.opt.directory = vim.fn.expand('~/.cache') .. '/nvim/swap'
vim.opt.undodir = vim.fn.expand('~/.cache') .. '/nvim/undo'

-- key mapping
vim.keymap.set('n', 'gb', '`.zz')
vim.keymap.set('i', 'jj', '<Esc>jj')
vim.keymap.set({'n', 'v'}, 'j', 'gj')
vim.keymap.set({'n', 'v'}, 'k', 'gk')

-- auto command
vim.api.nvim_create_augroup( 'default', {} )
vim.api.nvim_create_autocmd( 'InsertLeave', {
  group = 'default',
  callback = function() vim.opt.paste = false end
})
