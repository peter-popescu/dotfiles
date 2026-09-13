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

function SendHex(hex)
	return wezterm.action.SendString(utf8.char(hex))
end

config.keys = {
	-- Map Cmd + h/j/k/l to output obscure raw hex strings
	{ key = "h", mods = "CMD", action = SendHex(0xAA) },
	{ key = "j", mods = "CMD", action = SendHex(0xAB) },
	{ key = "k", mods = "CMD", action = SendHex(0xAC) },
	{ key = "l", mods = "CMD", action = SendHex(0xAD) },
	{ key = "v", mods = "CMD", action = wezterm.action.PasteFrom 'Clipboard' },
}

return config
