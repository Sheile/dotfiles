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
