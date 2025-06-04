vim.api.nvim_create_augroup('default', {})

-- Disable paste mode when leave
vim.api.nvim_create_autocmd('InsertLeave', {
  group = 'default',
  callback = function() vim.opt.paste = false end
})

-- Highlight trailing spaces
local disable_filetypes = { 'TelescopePrompt', 'TelescopeResults', 'diff', 'gitcommit', 'help', 'lazy', 'mason' }
vim.api.nvim_set_hl(0, 'TrailingSpaces', { bg = 'red' })
vim.api.nvim_create_autocmd({'VimEnter', 'BufEnter', 'WinEnter', 'FileType', 'InsertLeave'}, {
  group = 'default',
  callback = function()
    local match = GetMatch('TrailingSpaces')
    if match then
      if Contains(disable_filetypes, vim.bo.filetype) then
        vim.fn.matchdelete(match.id)
      end
    else
      if not Contains(disable_filetypes, vim.bo.filetype) then
        vim.fn.matchadd('TrailingSpaces', [[\s\+$]])
      end
    end
  end
})
vim.api.nvim_create_autocmd({'InsertEnter'}, {
  group = 'default',
  callback = function()
    local match = GetMatch('TrailingSpaces')
    if match then
      vim.fn.matchdelete(match.id)
    end
  end
})

-- Highlight unsaved buffer
vim.api.nvim_set_hl(0, 'UnsavedBuffer', { bg = '#5f0000' })
vim.api.nvim_create_autocmd({'VimEnter', 'BufEnter', 'WinEnter'}, {
  group = 'default',
  callback = function()
    vim.api.nvim_buf_set_option(0, 'winhighlight', '')
  end
})
vim.api.nvim_create_autocmd({'WinLeave'}, {
  group = 'default',
  callback = function()
    if vim.bo.modified then
      vim.api.nvim_buf_set_option(0, 'winhighlight', 'Normal:UnsavedBuffer,CursorLine:UnsavedBuffer')
    end
  end
})
