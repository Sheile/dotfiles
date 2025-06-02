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
