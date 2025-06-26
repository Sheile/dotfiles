require('helpers')

vim.scriptencoding = 'utf-8'
vim.g.mapleader = ' '

-- general configuration
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.matchtime = 3
vim.opt.list = true
vim.opt.listchars = 'tab:>-'
vim.opt.updatetime = 300

-- indent
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.breakindent = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'
vim.keymap.set('n', '<Esc>', '<Cmd>noh<CR>')

-- backup/swap/undofile
vim.opt.backup = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.backupdir = vim.fn.expand('~/.cache') .. '/nvim/backup'
vim.opt.directory = vim.fn.expand('~/.cache') .. '/nvim/swap'
vim.opt.undodir = vim.fn.expand('~/.cache') .. '/nvim/undo'

-- key mapping
vim.keymap.set('n', 'gb', '`.zz') -- Jump to last edit position and center it
vim.keymap.set('i', 'jj', '<Esc>jj') -- Handle wrong insert-mode input when moving down
vim.keymap.set({'n', 'v'}, 'j', 'gj') -- Move down one screen-line (wrapped text)
vim.keymap.set({'n', 'v'}, 'k', 'gk') -- Move up one screen-line (wrapped text)
vim.keymap.set({'x'}, 'p', 'P')  -- Preserve register contents when pasting over selection
vim.keymap.set({'n', 'x'}, 'x', '"_dl')  -- Preserve register contents when delete single character
vim.keymap.set({'o', 'x'}, 'i<Space>', 'iw')  -- Use 'i␣' as a text-object for the inner word (e.g. di␣ instead of diw)
vim.keymap.set({'n'}, 'U', '<C-r>')  -- Redo with 'U' (complement to undo with 'u')
vim.keymap.set({'n'}, 'M', '%') -- Jump to matching parenthesis
vim.keymap.set({'n'}, 'i', function() -- On empty line, enter insert mode with indentation
  if vim.fn.getline('.') == '' then
    return '"_cc'
  end
  return 'i'
end, { expr = true, noremap = true, silent = true })

-- auto command
require('autocommand')

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
