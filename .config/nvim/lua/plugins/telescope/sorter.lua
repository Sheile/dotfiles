-- Patched the get_substr_matcher sorter defined in Telescope
-- - Prefer an exact match
-- - Prefer a prefix match on the first word (split by spaces)
return function()
  local util = require "telescope.utils"
  local Sorter = require('telescope.sorters').Sorter
  local substr_highlighter = function(make_display)
    return function(_, prompt, display)
      local highlights = {}
      display = make_display(prompt, display)

      local search_terms = util.max_split(prompt, "%s")
      local hl_start, hl_end

      for _, word in pairs(search_terms) do
        hl_start, hl_end = display:find(word, 1, true)
        if hl_start then
          table.insert(highlights, { start = hl_start, finish = hl_end })
        end
      end

      return highlights
    end
  end

  local make_display = vim.o.smartcase
      and function(prompt, display)
        local has_upper_case = not not prompt:match "%u"
        return has_upper_case and display or display:lower()
      end
    or function(_, display)
      return display:lower()
    end

  return Sorter:new {
    highlighter = substr_highlighter(make_display),
    scoring_function = function(_, prompt, _, entry)
      if #prompt == 0 then
        return 1
      end

      local display = make_display(prompt, entry.ordinal)
      if display == prompt then
        return 1
      end

      local search_terms = util.max_split(prompt, "%s")
      for _, word in pairs(search_terms) do
        if not display:find(word, 1, true) then
          return -1
        end
      end

      local prefix = search_terms[1]
      if display:sub(1, #prefix) == prefix then
        return entry.index + 1
      end

      return entry.index + 10000
    end,
  }
end
