vim.api.nvim_create_augroup('default', {})

-- Disable paste mode when leave
vim.api.nvim_create_autocmd('InsertLeave', {
  group = 'default',
  callback = function() vim.opt.paste = false end
})

-- Highlight trailing spaces
local disable_filetypes = { 'TelescopePrompt', 'gitcommit', 'help', 'lazy', 'mason' }
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
