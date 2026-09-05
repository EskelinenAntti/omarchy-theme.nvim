return {
	test_apply = function()
		-- Given
		local theme = require("omarchy-theme")
		local env = require("omarchy-theme.environment")
		env.omarchy_current_theme_colors_path = "tests/current/theme/colors.toml"
		env.omarchy_current_theme_name_path = "tests/current/theme.name"

		-- When
		theme.apply()

		-- Then
		local want = "#c2c2b0"
		local got = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).fg)
		assert(got == want, "want:" .. want .. ",got:" .. got)
	end,
	test_apply_outside_of_omarchy = function()
		-- Given
		local want = "#ffffff"
		vim.api.nvim_set_hl(0, "Normal", { fg = want })

		local theme = require("omarchy-theme")
		local env = require("omarchy-theme.environment")
		env.omarchy_current_theme_colors_path = "tests/not-existing/theme/colors.toml"
		env.omarchy_current_theme_name_path = "tests/not-existing/theme.name"
		-- When
		theme.apply()

		-- Then
		local got = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).fg)
		assert(got == want, "want:" .. want .. ",got:" .. got)
	end,
	test_apply_clears_old_highlights = function()
		-- Given
		vim.api.nvim_set_hl(0, "HighlightGroupToClear", { fg = "#ffffff" })

		local theme = require("omarchy-theme")
		local env = require("omarchy-theme.environment")
		env.omarchy_current_theme_colors_path = "tests/current/theme/colors.toml"
		env.omarchy_current_theme_name_path = "tests/current/theme.name"
		-- When
		theme.apply()

		-- Then
		assert(vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = "HighlightGroupToClear" })))
	end,
}
