---@class AnsiPalette
---@field background integer
---@field red integer
---@field green integer
---@field yellow integer
---@field blue integer
---@field magenta integer
---@field cyan integer
---@field foreground integer
---@field selection integer
---@field bright_red integer
---@field bright_green integer
---@field bright_yellow integer
---@field bright_blue integer
---@field bright_magenta integer
---@field bright_cyan integer
---@field bright_foreground integer

---@class GuiPalette
---@field mode "dark"|"light"
---@field accent string
---@field selection string
---@field muted string
---@field background string
---@field dark_background string
---@field darker_background string
---@field lighter_background string
---@field foreground string
---@field dark_foreground string
---@field light_foreground string
---@field bright_foreground string
---@field red string
---@field yellow string
---@field orange string
---@field green string
---@field cyan string
---@field blue string
---@field magenta string
---@field bright_red string
---@field bright_yellow string
---@field bright_green string
---@field bright_cyan string
---@field bright_blue string
---@field bright_magenta string

return {
	---Map raw colors from colors.toml into a GUI palette.
	---@param toml table<string, string> Raw colors from colors.toml
	---@return GuiPalette
	gui_palette = function(toml)
		return {
			mode = toml.mode,
			accent = toml.accent,
			selection = toml.selection,
			muted = toml.muted,
			background = toml.background,
			dark_background = toml.dark_background,
			darker_background = toml.darker_background,
			lighter_background = toml.lighter_background,
			foreground = toml.foreground,
			dark_foreground = toml.dark_foreground,
			light_foreground = toml.light_foreground,
			bright_foreground = toml.bright_foreground,
			red = toml.red,
			yellow = toml.yellow,
			orange = toml.orange or toml.yellow,
			green = toml.green,
			cyan = toml.cyan,
			blue = toml.blue,
			magenta = toml.magenta,
			bright_red = toml.bright_red,
			bright_yellow = toml.bright_yellow,
			bright_green = toml.bright_green,
			bright_cyan = toml.bright_cyan,
			bright_blue = toml.bright_blue,
			bright_magenta = toml.bright_magenta,
		}
	end,

	---@type AnsiPalette
	ansi_palette = {
		background = 0,
		red = 1,
		green = 2,
		yellow = 3,
		blue = 4,
		magenta = 5,
		cyan = 6,
		foreground = 7,
		selection = 8,
		bright_red = 9,
		bright_green = 10,
		bright_yellow = 11,
		bright_blue = 12,
		bright_magenta = 13,
		bright_cyan = 14,
		bright_foreground = 15,
	},
}
