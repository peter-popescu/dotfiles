local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Appearance
config.color_scheme = "Dracula (Official)"
config.font = wezterm.font("Fira Code")
config.font_size = 16

config.window_background_opacity = 0.80
config.window_decorations = "RESIZE"
config.window_padding = { left = "1cell", right = "1cell", top = "0.5cell", bottom = 0 }
config.macos_window_background_blur = 10
config.enable_tab_bar = false

-- Bindings
config.disable_default_key_bindings = true

return config
