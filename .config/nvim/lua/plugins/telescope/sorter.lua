-- Patched the get_substr_matcher sorter defined in Telescope
-- - Prefer an exact match
-- - Prefer a prefix match on the first word (split by spaces)
-- - Support escaped spaces (\ ) for searching strings containing spaces
return function()
  local util = require "telescope.utils"
  local Sorter = require('telescope.sorters').Sorter

  -- Split by spaces that are not preceded by backslash
  local function split_by_unescaped_spaces(str)
    local terms = {}
    local current_word = ""
    local i = 1

    while i <= #str do
      local char = str:sub(i, i)
      local next_char = str:sub(i + 1, i + 1)

      if char == "\\" and next_char == " " then
        -- Escaped space: add space to current word
        current_word = current_word .. next_char
        i = i + 2
      elseif char == " " then
        -- Unescaped space: end current word and start new one
        if #current_word > 0 then
          table.insert(terms, current_word)
          current_word = ""
        end
        i = i + 1
      else
        -- Regular character: add to current word
        current_word = current_word .. char
        i = i + 1
      end
    end

    -- Add the last word if it exists
    if #current_word > 0 then
      table.insert(terms, current_word)
    end

    return terms
  end

  local substr_highlighter = function(make_display)
    return function(_, prompt, display)
      local highlights = {}
      display = make_display(prompt, display)

      local search_terms = split_by_unescaped_spaces(prompt)
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

      local search_terms = split_by_unescaped_spaces(prompt)

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
