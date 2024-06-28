--- @alias battery_state 'Charging' | 'Discharging' | 'Empty' | 'Full' | 'Unknown'
--- @alias battery { state: battery_state, state_of_charge: number }
--
local wezterm = require('wezterm')
local utils = require('utils')
local icons = wezterm.nerdfonts
local is_studio = string.find(wezterm.hostname(), 'Studio') ~= nil
local tilde = ''

local M = {}

local function parse_remote_machine(active_pane)
  local process_name = utils.parse_process_name(active_pane:get_foreground_process_name())
  local hostname, _ = utils.parse_host_path_from_title(process_name, active_pane:get_title())
  local output_str = icons['md_alpha_k_box_outline']
  if hostname then
    output_str = string.format('%s %s', icons['cod_radio_tower'], hostname:match('^([^.]+)'))
  end
  return string.format('%s%s ', icons['md_power_on'], output_str)
end

local function apply_fmt(fg, bg, appled_str)
  local fmt_array = {}
  if fg then
    table.insert(fmt_array, { Foreground = { AnsiColor = fg } })
  end

  if bg then
    table.insert(fmt_array, { Background = { AnsiColor = bg } })
  end
  table.insert(fmt_array, { Text = appled_str })

  return wezterm.format(fmt_array)
end

--- @param battery battery state of charge, from 0.00 to 1.00
--- @return string
local function render_battery(battery)
  --- @type table<string, string>

  if is_studio then
    return string.format(
      '%s%s',
      apply_fmt('Green', nil, tilde),
      apply_fmt('Black', 'Green', string.format(' %s ', icons['cod_plug']))
    )
  end

  local percent = battery.state_of_charge
  -- local formatted_percent = string.format('%.0f%%', percent * 100)

  local prefix = 'md_battery'
  if battery.state == 'Charging' then
    prefix = prefix .. '_charging'
  end

  local icon_name

  if percent == 1 then
    icon_name = 'md_battery_charging_100'
  else
    local suffix = math.max(1, math.ceil(percent * 10)) .. '0'
    icon_name = prefix .. '_' .. suffix
  end

  return string.format(
    '%s%s',
    apply_fmt('Green', nil, tilde),
    apply_fmt('Black', 'Green', string.format(' %s ', icons[icon_name]))
  )
end

local function get_mac_icon()
  local mac_icon = icons['md_laptop']
  if is_studio then
    mac_icon = icons['md_slot_machine_outline']
  end
  return string.format(
    '%s%s',
    apply_fmt('Yellow', 'Silver', tilde),
    apply_fmt('Black', 'Yellow', string.format(' %s ', mac_icon))
  )
end

local function update_right_status(window, active_pane)
  local hostname = apply_fmt('White', nil, parse_remote_machine(active_pane))

  -- "Mar 3[Wed] 08:14"
  --- @type string
  local date = string.format(
    '%s%s',
    apply_fmt('Silver', 'Green', tilde),
    apply_fmt('Black', 'Silver', string.format(' %s ', wezterm.strftime('%b %-d[%a] %H:%M')))
  )

  -- --- @type string
  -- local tilde = wezterm.format({
  --   { Foreground = { AnsiColor = 'Fuchsia' } },
  --   { Text = icons['cod_triangle_left'] },
  -- })
  --
  --- @type string
  local battery

  for _, b in ipairs(wezterm.battery_info()) do
    battery = render_battery(b)
  end

  window:set_right_status(wezterm.format({
    { Text = string.format('%s%s%s%s', hostname, battery, date, get_mac_icon()) },
  }))
end

function M.apply(_)
  wezterm.on('update-status', update_right_status)
end

return M
