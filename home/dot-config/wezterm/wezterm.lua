local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Frappe"
config.font_size = 13
config.line_height = 1.2
config.send_composed_key_when_right_alt_is_pressed = false
config.enable_tab_bar = false
config.background = require("alien_background")

return config
