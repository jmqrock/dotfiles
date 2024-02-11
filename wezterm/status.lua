--- @alias battery_state 'Charging' | 'Discharging' | 'Empty' | 'Full' | 'Unknown'
--- @alias battery { state: battery_state, state_of_charge: number }
--
local wezterm = require('wezterm')
local icons = wezterm.nerdfonts
local hostname = wezterm.hostname()

local M = {}

--- @param battery battery state of charge, from 0.00 to 1.00
--- @return string
local function render_battery(battery)
  --- @type table<string, string>

  if string.find(hostname, 'Studio') ~= nil then
    return wezterm.format({
      { Foreground = { AnsiColor = 'Green' } },
      -- { Text = icons['md_desktop_mac'] },
      { Text = icons['cod_plug'] },
    })
  end

  local percent = battery.state_of_charge
  local formatted_percent = string.format('%.0f%%', percent * 100)

  local get_icon = function()
    local prefix = 'md_battery'
    if battery.state == 'Charging' then
      return icons[prefix .. '_charging']
    end

    local icon_name

    if percent == 1 then
      icon_name = 'md_battery_charging_100'
    else
      local suffix = math.max(1, math.ceil(percent * 10)) .. '0'
      icon_name = prefix .. '_' .. suffix
    end

    local color = percent <= 0.1 and 'Red' or 'Green'
    return wezterm.format({
      { Foreground = { AnsiColor = color } },
      { Text = icons[icon_name] },
    })
  end

  return string.format('%s %s', get_icon(), formatted_percent)
end

local function get_mac_icon()
  local mac_icon = icons['md_laptop']
  if string.find(hostname, 'Studio') ~= nil then
    mac_icon = icons['md_desktop_mac']
  end
  return wezterm.format({
    { Foreground = { AnsiColor = 'Green' } },
    { Text = mac_icon },
  })
end

local function update_right_status(window)
  -- "Mar 3[Wed] 08:14"
  --- @type string
  local date = wezterm.strftime('%b %-d[%a] %H:%M')

  --- @type string
  local tilde = wezterm.format({
    { Foreground = { AnsiColor = 'Fuchsia' } },
    { Text = '|' },
  })

  --- @type string
  local battery

  for _, b in ipairs(wezterm.battery_info()) do
    battery = render_battery(b)
  end

  window:set_right_status(wezterm.format({
    { Text = string.format('%s %s%s %s%s ', battery, tilde, date, tilde, get_mac_icon()) },
  }))
end

function M.apply(_)
  wezterm.on('update-right-status', update_right_status)
end

return M
