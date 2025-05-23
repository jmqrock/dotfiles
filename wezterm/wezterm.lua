-- Pull in the wezterm API
local wezterm = require('wezterm')
local tab_conf = require('tab')
local fonts_conf = require('fonts')
local key_bind_conf = require('bindings')
local right_status = require('status')

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
tab_conf.apply(config)
fonts_conf.apply(config)
key_bind_conf.apply(config)
right_status.apply(config)

-- Spawn a fish shell in login mode
-- config.default_prog = { '/opt/homebrew/bin/nu' }
config.enable_scroll_bar = true
config.animation_fps = 60
config.max_fps = 60
config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'
-- config.color_scheme = 'Tokyo Night Storm'
config.color_scheme = 'darkmoss (base16)'
config.automatically_reload_config = false

config.window_background_opacity = 0.98
-- config.text_background_opacity = 0.3

-- window
config.window_padding = {
  left = 5,
  right = 10,
  top = 2,
  bottom = 3,
}
config.window_frame = {
  active_titlebar_bg = '#090909',
  -- font = fonts.font,
  -- font_size = fonts.font_size,
}
config.inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 }

-- and finally, return the configuration to wezterm
return config
