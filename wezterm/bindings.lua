local wezterm = require('wezterm')
-- local platform = require("utils.platform")()
-- local backdrops = require("utils.backdrops")
local act = wezterm.action

local M = {}
local mod = {}

-- if platform.is_mac then
mod.SUPER = 'SUPER'
mod.SUPER_REV = 'SUPER|SHIFT'
mod.SUPER_ALT = 'SUPER|ALT'

local home = os.getenv('HOME')
local my_pwd = ''

for line in io.lines(home .. '/.zshrc') do
  -- to find my password
  if string.find(line, 'KARAS_PASSWORD') then
    local _, pwd = line:match('([^=]+)=([^=]+)')
    my_pwd = pwd:gsub('"', ''):gsub("'", '') .. '\n'
  end
end

local keys = {
  -- send the password to console --
  { key = 'p', mods = 'SUPER|SHIFT|CTRL', action = wezterm.action.SendString(my_pwd) },

  -- reload config --
  { key = 'r', mods = mod.SUPER_REV, action = act.ReloadConfiguration },

  -- misc/useful --
  { key = 'F1', mods = 'NONE', action = act.ActivateCopyMode },
  { key = 'F5', mods = 'NONE', action = act.QuickSelect },
  { key = 'F2', mods = 'NONE', action = act.ActivateCommandPalette },
  { key = 'p', mods = mod.SUPER, action = act.ActivateCommandPalette },
  { key = 'F3', mods = 'NONE', action = act.ShowLauncher },
  { key = 'F4', mods = 'NONE', action = act.ShowTabNavigator },
  { key = 'F12', mods = 'NONE', action = act.ShowDebugOverlay },
  -- { key = 'f', mods = mod.SUPER, action = act.Search('CurrentSelectionOrEmptyString') },
  {
    key = 'f',
    mods = mod.SUPER,
    action = act.Multiple({
      act.Search({ CaseSensitiveString = '' }),
      act.CopyMode('ClearPattern'),
    }),
  },

  -- copy/paste --
  { key = 'c', mods = mod.SUPER, action = act.CopyTo('Clipboard') },
  { key = 'v', mods = mod.SUPER, action = act.PasteFrom('Clipboard') },

  -- tabs --
  -- tabs: spawn+close
  { key = 't', mods = mod.SUPER, action = act.SpawnTab('DefaultDomain') },
  { key = 't', mods = mod.SUPER_REV, action = act.SpawnTab({ DomainName = 'WSL:Ubuntu' }) },
  { key = 'w', mods = mod.SUPER_REV, action = act.CloseCurrentTab({ confirm = true }) },

  -- tabs: navigation
  { key = '[', mods = mod.SUPER_REV, action = act.ActivateTabRelative(-1) },
  { key = ']', mods = mod.SUPER_REV, action = act.ActivateTabRelative(1) },
  { key = '[', mods = mod.SUPER_ALT, action = act.MoveTabRelative(-1) },
  { key = ']', mods = mod.SUPER_ALT, action = act.MoveTabRelative(1) },

  -- window --
  -- spawn windows
  { key = 'n', mods = mod.SUPER, action = act.SpawnWindow },

  -- background controls --
  -- {
  -- 	key = [[/]],
  -- 	mods = mod.SUPER_REV,
  -- 	action = wezterm.action_callback(function(window, _pane)
  -- 		backdrops:random(window)
  -- 	end),
  -- },
  -- {
  -- 	key = [[,]],
  -- 	mods = mod.SUPER_REV,
  -- 	action = wezterm.action_callback(function(window, _pane)
  -- 		backdrops:cycle_back(window)
  -- 	end),
  -- },
  -- {
  -- 	key = [[.]],
  -- 	mods = mod.SUPER_REV,
  -- 	action = wezterm.action_callback(function(window, _pane)
  -- 		backdrops:cycle_forward(window)
  -- 	end),
  -- },

  -- panes --
  -- panes: split panes
  {
    key = [[\]],
    mods = mod.SUPER,
    action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = 'Enter',
    mods = mod.SUPER_REV,
    action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = [[\]],
    mods = mod.SUPER_REV,
    action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = 'Enter',
    mods = mod.SUPER,
    action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
  },

  -- panes: zoom+close pane
  { key = 'z', mods = mod.SUPER_REV, action = act.TogglePaneZoomState },
  { key = 'w', mods = mod.SUPER, action = act.CloseCurrentPane({ confirm = true }) },
  { key = 's', mods = mod.SUPER_REV, action = act.PaneSelect },

  -- panes: navigation
  { key = 'k', mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Up') },
  { key = 'j', mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Down') },
  { key = 'h', mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Left') },
  { key = 'l', mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Right') },

  -- key-tables --
  -- resizes fonts
  {
    key = 'f',
    mods = 'LEADER',
    action = act.ActivateKeyTable({
      name = 'resize_font',
      one_shot = false,
      timemout_miliseconds = 1000,
    }),
  },
  -- resize panes
  {
    key = 'p',
    mods = 'LEADER',
    action = act.ActivateKeyTable({
      name = 'resize_pane',
      one_shot = false,
      timemout_miliseconds = 1000,
    }),
  },
}

local key_tables = {
  resize_font = {
    { key = 'k', action = act.IncreaseFontSize },
    { key = 'j', action = act.DecreaseFontSize },
    { key = 'r', action = act.ResetFontSize },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q', action = 'PopKeyTable' },
  },
  resize_pane = {
    { key = 'k', action = act.AdjustPaneSize({ 'Up', 1 }) },
    { key = 'j', action = act.AdjustPaneSize({ 'Down', 1 }) },
    { key = 'h', action = act.AdjustPaneSize({ 'Left', 1 }) },
    { key = 'l', action = act.AdjustPaneSize({ 'Right', 1 }) },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q', action = 'PopKeyTable' },
  },
}

local mouse_bindings = {
  -- Ctrl-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },
}

function M.apply_to_config(config)
  config.disable_default_key_bindings = true
  config.leader = { key = 'b', mods = 'CTRL' }
  config.keys = keys
  config.key_tables = key_tables
  config.mouse_bindings = mouse_bindings
end

return M
