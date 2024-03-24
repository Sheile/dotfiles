function switch_by_cmdtype(pattern, key_when_matched, key_when_unmatched)
 return function()
   if string.match(vim.fn.getcmdtype(), pattern) then
     return key_when_matched
   else
     return key_when_unmatched
   end
  end
end
