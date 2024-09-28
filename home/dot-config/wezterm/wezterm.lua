local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- config.color_scheme = "Catppuccin Frappe"
-- config.color_scheme = "Default Dark (base16)"
config.color_scheme = "Vs Code Dark+ (Gogh)"
config.font_size = 13
config.line_height = 1.2
config.send_composed_key_when_right_alt_is_pressed = false
config.enable_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
