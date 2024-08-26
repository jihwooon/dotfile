local wezterm = require("wezterm")
local actions = require("actions")
local keymaps = require("keymaps")

local os = require('os')
local home_path = os.getenv('HOME')

return {
  font = wezterm.font_with_fallback({ 'JetBrains Mono', 'NanumBarunGothic' }),
  font_size = 12.5,
  line_height = 1.2,
  window_background_opacity = 0.75,
  keys = keymaps,
  automatically_reload_config = true,
  color_scheme = 'tokyonight_moon',
  window_background_gradient = {
    colors = { '#000', '#002' },
    orientation = { Linear = { angle = -45.0 } },
    interpolation = 'Linear',
    blend = 'Rgb',
  },
}
