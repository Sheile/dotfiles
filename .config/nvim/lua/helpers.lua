function Contains(list, x)
  for _, v in ipairs(list) do
    if v == x then return true end
  end
  return false
end

function GetMatch(group)
  for _, match in ipairs(vim.fn.getmatches()) do
    if match.group == group then
      return match
    end
  end
  return nil
end

function GetXdgConfigHome()
  local xdg = os.getenv('XDG_CONFIG_HOME')
  if xdg ~= nil and xdg ~= '' then
    return xdg
  end
  return os.getenv('HOME') .. '/.config'
end

-- Check if current window is floating
function IsFloatingWindow()
  local win_config = vim.api.nvim_win_get_config(0)
  return win_config.relative ~= ''
end
