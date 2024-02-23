local utils = {}

local function sub_str(input_str)
  if input_str == nil then
    return ''
  end

  if input_str:len() <= 13 then
    return input_str
  end

  return ".." .. string.sub(input_str, -13)
end

function utils.parse_host_path_from_title(process_name, base_title)
  -- Pattern to match the user@hostname:path format
  if process_name == 'ssh' and base_title then
    local _, hostname, path = base_title:match('^(.-)@(.-):(.+)$')
    if hostname and path then
      return hostname, sub_str(path)
    else
      -- Pattern to match the hostname:path format
      hostname, path = base_title:match('^(.-):(.+)$')
      if hostname and path then
        return hostname, sub_str(path)
      end
    end
  end
  return nil, base_title
end

function utils.parse_process_name(s)
  local fg_process = s or ''
  local a = string.gsub(fg_process, '(.*[/\\])(.*)', '%2')
  return a:gsub('%.exe$', '')
end

return utils
