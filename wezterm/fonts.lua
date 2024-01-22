local wezterm = require('wezterm')

local M = {}
local font_size = 16

function M.apply_to_config(config)
  config.dpi = 114
  config.font = wezterm.font_with_fallback({
    {
      family = 'Hack Nerd Font',
    },
    { family = 'Hannotate SC' },
  })
  -- config.font = wezterm.font(font)
  config.font_size = font_size
  config.freetype_load_target = 'Normal' ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
  config.freetype_render_target = 'Normal' ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
end

return M
