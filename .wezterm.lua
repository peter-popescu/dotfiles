-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Set env vars for spawning 
-- config.set_environment_variables = {
--   PATH = '/opt/homebrew/bin:' .. os.getenv('PATH')
-- }

-- This is where you actually apply your config choices

config.color_scheme = "Dracula (Official)"

-- config.max_fps = 90

config.font = wezterm.font("Fira Code")
-- config.font = wezterm.font("JetBrains Mono")
-- config.font = wezterm.font("MesloLGS Nerd Font Mono")

config.font_size = 16

config.window_background_opacity = 0.80
config.macos_window_background_blur = 10

config.window_decorations = "RESIZE"

-- Keymaps
local act = wezterm.action

config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	-- { key = "LeftArrow", mods = "OPT", action = act.SendString("\x1bb") },
	-- Make Option-Right equivalent to Alt-f; forward-word
	-- { key = "RightArrow", mods = "OPT", action = act.SendString("\x1bf") },
	-- Make Cmd-Right equivalent to end of line
	{ key = "RightArrow", mods = "CMD", action = act.SendString("\x05") },
	-- Make Cmd-Left equivalent to beginning of line
	{ key = "LeftArrow", mods = "CMD", action = act.SendString("\x01") },
	-- Make Cmd-Del equivalent to clear line to beginning
	{ key = "Backspace", mods = "CMD", action = act.SendString("\x15") },
	{
		key = ",",
		mods = "SUPER",
		action = wezterm.action.SendString('\x02c nvim ' .. wezterm.config_file .. '\n'),
	},
	-- Clears the scrollback and viewport leaving the prompt line the new first line.
	-- {
	-- 	key = "k",
	-- 	mods = "CMD",
	-- 	action = act.Multiple({
	-- 		act.ClearScrollback("ScrollbackAndViewport"),
	-- 		act.SendKey({ key = "L", mods = "CTRL" }),
	-- 	}),
	-- },
}

-- Tab bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.switch_to_last_active_tab_when_closing_tab = true
config.tab_max_width = 32

config.window_padding = { left = "1cell", right = "1cell", top = "0.5cell", bottom = 0 }

wezterm.on("update-status", function(window)
	-- Get hostname
	local hostname = wezterm.hostname()
	local dot = hostname:find("[.]")
	-- Remove the domain name portion of the hostname
	if dot then
		hostname = hostname:sub(1, dot - 1)
	end
	if hostname == "" then
		hostname = wezterm.hostname()
	end

	window:set_left_status(wezterm.format({
		-- Then we draw our text
		{ Background = { Color = "#50FA7B" } },
		{ Foreground = { Color = "#000000" } },
		{ Text = " " .. hostname .. " " },
	}))
end)

-- and finally, return the configuration to wezterm
return config
