return {

	["Omarchy theme colors are applied as Neovim highlights"] = function()
		-- Given
		local theme = require("omarchy-theme")
		local env = require("omarchy-theme.environment")
		env.omarchy_current_theme_colors_path = "tests/current/theme/colors.toml"
		env.omarchy_current_theme_name_path = "tests/current/theme.name"

		-- When
		theme.apply()

		-- Then
		local got = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).fg)
		local want = "#c2c2b0"
		assert(got == want, "got:" .. got .. ",want" .. want)
	end,

	["Neovim highlights are not updated outside of Omarchy"] = function()
		-- Given
		local old_highlight = "#ffffff"
		vim.api.nvim_set_hl(0, "Normal", { fg = old_highlight })

		local theme = require("omarchy-theme")
		local env = require("omarchy-theme.environment")
		env.omarchy_current_theme_colors_path = "tests/not-existing/theme/colors.toml"
		env.omarchy_current_theme_name_path = "tests/not-existing/theme.name"

		-- When
		theme.apply()

		-- Then
		local got = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).fg)
		assert(got == old_highlight, "got:" .. got .. ",want:" .. old_highlight)
	end,

	["Previous highlights set by other themes are cleared"] = function()
		-- Given
		vim.api.nvim_set_hl(0, "HighlightGroupToClear", { fg = "#ffffff" })

		local theme = require("omarchy-theme")
		local env = require("omarchy-theme.environment")
		env.omarchy_current_theme_colors_path = "tests/current/theme/colors.toml"
		env.omarchy_current_theme_name_path = "tests/current/theme.name"

		-- When
		theme.apply()

		-- Then
		assert(vim.api.nvim_get_hl(0, { name = "HighlightGroupToClear" }).fg == nil, "Highlights were not cleared")
	end,
}
