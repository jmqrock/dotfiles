-- local os = require('os')
local wezterm = require('wezterm')
local icons = wezterm.nerdfonts
local M = {}

-- This function is private to this module and is not visible
-- outside.
local function private_helper()
  wezterm.log_info('load tab config!')
end

local GLYPH_SEMI_CIRCLE_LEFT = icons['ple_lower_right_triangle']
-- local GLYPH_SEMI_CIRCLE_LEFT = ''
-- local GLYPH_SEMI_CIRCLE_LEFT = utf8.char(0xe0b6)
local GLYPH_SEMI_CIRCLE_RIGHT = icons['ple_upper_left_triangle']
-- local GLYPH_SEMI_CIRCLE_RIGHT = ''
-- local GLYPH_SEMI_CIRCLE_RIGHT = utf8.char(0xe0b4)
local GLYPH_CIRCLE = icons['cod_eye']
-- local GLYPH_CIRCLE = ''
-- local GLYPH_CIRCLE = utf8.char(0xf111)
local GLYPH_ADMIN = icons['fae_radioactive']
-- local GLYPH_ADMIN = '󰞀'
-- local GLYPH_ADMIN = utf8.char(0xf0780)

M.cells = {}

M.colors = {
  default = {
    bg = { AnsiColor = 'Green' },
    fg = { AnsiColor = 'Black' },
  },
  is_active = {
    bg = { AnsiColor = 'Yellow' },
    fg = { AnsiColor = 'Black' },
  },

  hover = {
    bg = { AnsiColor = 'Red' },
    fg = { AnsiColor = 'Black' },
  },
}

local function parse_remote_machine(process_name, title_str)
  if process_name == 'ssh' and title_str and string.find(title_str, ':') ~= nil then
    local _, cur_path = title_str:match("([^:]+) : (.+)")
    return cur_path or title_str
  end
  return title_str
end

M.set_process_name = function(s)
  local a = string.gsub(s, '(.*[/\\])(.*)', '%2')
  return a:gsub('%.exe$', '')
end

M.set_title = function(process_name, base_title, max_width, inset)
  local title
  inset = inset or 6

  local parsed_title = parse_remote_machine(process_name, base_title)

  if process_name:len() > 0 then
    title = process_name .. '⏽' .. parsed_title
  else
    title = parsed_title
  end

  if title:len() > max_width - inset then
    local diff = title:len() - max_width + inset
    title = wezterm.truncate_right(title, title:len() - diff)
  end

  return title
end

M.check_if_admin = function(p)
  if p:match('^Administrator: ') then
    return true
  end
  return false
end

---@param fg table
---@param bg table
---@param attribute table
---@param text string
M.push = function(bg, fg, attribute, text)
  table.insert(M.cells, { Background = bg })
  table.insert(M.cells, { Foreground = fg })
  table.insert(M.cells, { Attribute = attribute })
  table.insert(M.cells, { Text = text })
end

function M.apply(config)
  config.enable_tab_bar = true
  config.use_fancy_tab_bar = false
  config.tab_bar_at_bottom = true
  config.hide_tab_bar_if_only_one_tab = false
  config.use_fancy_tab_bar = false
  config.tab_max_width = 30
  config.show_tab_index_in_tab_bar = true
  config.switch_to_last_active_tab_when_closing_tab = true

  config.colors = {
    tab_bar = {
      background = 'Black',
    },
  }

  wezterm.on('new-tab-button-click', function(window, pane, button, default_action)
    wezterm.log_info('new-tab', window, pane, button, default_action)
    if default_action and button == 'Left' then
      window:perform_action(default_action, pane)
    end

    if default_action and button == 'Right' then
      window:perform_action(
        wezterm.action.ShowLauncherArgs({
          title = '  Select/Search:',
          flags = 'FUZZY|LAUNCH_MENU_ITEMS|DOMAINS',
        }),
        pane
      )
    end
    return false
  end)

  wezterm.on('format-tab-title', function(tab, _, _, _, hover, max_width)
    M.cells = {}

    local bg
    local fg
    local process_name = M.set_process_name(tab.active_pane.foreground_process_name)
    local is_admin = M.check_if_admin(tab.active_pane.title)
    local title = M.set_title(process_name, tab.active_pane.title, max_width, (is_admin and 8))

    if tab.is_active then
      bg = M.colors.is_active.bg
      fg = M.colors.is_active.fg
    elseif hover then
      bg = M.colors.hover.bg
      fg = M.colors.hover.fg
    else
      bg = M.colors.default.bg
      fg = M.colors.default.fg
    end

    local has_unseen_output = false
    for _, pane in ipairs(tab.panes) do
      if pane.has_unseen_output then
        has_unseen_output = true
        break
      end
    end

    -- Left semi-circle
    M.push(fg, bg, { Intensity = 'Normal' }, GLYPH_SEMI_CIRCLE_LEFT)

    -- Admin Icon
    if is_admin then
      M.push(bg, fg, { Intensity = 'Normal' }, ' ' .. GLYPH_ADMIN)
    end

    -- Title
    M.push(bg, { Color = 'Black' }, { Intensity = 'Bold' }, ' ' .. title)

    -- Unseen output alert
    if has_unseen_output then
      M.push(bg, { Color = '#FFA066' }, { Intensity = 'Normal' }, ' ' .. GLYPH_CIRCLE)
    end

    -- Right padding
    M.push(bg, fg, { Intensity = 'Bold' }, ' ')

    -- Right semi-circle
    M.push(fg, bg, { Intensity = 'Bold' }, GLYPH_SEMI_CIRCLE_RIGHT)

    return M.cells
  end)
end

return M
