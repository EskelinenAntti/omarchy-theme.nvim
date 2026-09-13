return {
	after = function()
		vim.opt.termguicolors = true
	end,

	["Omarchy theme colors are applied as Neovim highlights"] = function()
		-- Given
		local env = require("omarchy-theme.environment")
		env.omarchy_current_theme_colors_path = "tests/current/theme/colors.toml"
		env.omarchy_current_theme_name_path = "tests/current/theme.name"

		-- When
		vim.cmd.colorscheme("omarchy")

		-- Then
		local got = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).fg)
		local want = "#c2c2b0"
		assert(got == want, "got:" .. got .. ",want" .. want)
		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
		assert(normal.ctermfg == 7, "Normal ctermfg got:" .. vim.inspect(normal.ctermfg))
		assert(normal.ctermbg == 0, "Normal ctermbg got:" .. vim.inspect(normal.ctermbg))

		local string_hl = vim.api.nvim_get_hl(0, { name = "String" })
		assert(string_hl.ctermfg == 2, "String ctermfg got:" .. vim.inspect(string_hl.ctermfg))
	end,

	["Neovim highlights are not updated outside of Omarchy"] = function()
		-- Given
		local old_highlight = "#ffffff"
		vim.api.nvim_set_hl(0, "Normal", { fg = old_highlight })

		local env = require("omarchy-theme.environment")
		env.omarchy_current_theme_colors_path = "tests/not-existing/theme/colors.toml"
		env.omarchy_current_theme_name_path = "tests/not-existing/theme.name"
		vim.opt.termguicolors = true
		-- When
		vim.cmd.colorscheme("omarchy")

		-- Then
		local got = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).fg)
		assert(got == old_highlight, "got:" .. got .. ",want:" .. old_highlight)
	end,

	["Load ANSI colors even when no Omarchy configuration is found if termguicolors is off"] = function()
		-- Given
		local env = require("omarchy-theme.environment")
		env.omarchy_current_theme_colors_path = "tests/not-existing/theme/colors.toml"
		env.omarchy_current_theme_name_path = "tests/not-existing/theme.name"
		vim.opt.termguicolors = false
		-- When
		vim.cmd.colorscheme("omarchy")

		-- Then
		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
		assert(normal.ctermfg == 7, "Normal ctermfg got:" .. vim.inspect(normal.ctermfg))
		assert(normal.ctermbg == 0, "Normal ctermbg got:" .. vim.inspect(normal.ctermbg))
		assert(normal.fg == nil, "Normal ctermbg got:" .. vim.inspect(normal.fg))
	end,

	["Previous highlights set by other themes are cleared"] = function()
		-- Given
		vim.api.nvim_set_hl(0, "HighlightGroupToClear", { fg = "#ffffff" })

		local env = require("omarchy-theme.environment")
		env.omarchy_current_theme_colors_path = "tests/current/theme/colors.toml"
		env.omarchy_current_theme_name_path = "tests/current/theme.name"

		-- When
		vim.cmd.colorscheme("omarchy")

		-- Then
		assert(vim.api.nvim_get_hl(0, { name = "HighlightGroupToClear" }).fg == nil, "Highlights were not cleared")
	end,

	["Use yellow as fallback when theme does not define orange color"] = function()
		-- Given
		vim.api.nvim_set_hl(0, "Boolean", { fg = "#ffffff" })

		local env = require("omarchy-theme.environment")
		env.omarchy_current_theme_colors_path = "tests/current/theme/colors-without-orange.toml"
		env.omarchy_current_theme_name_path = "tests/current/theme.name"

		-- When
		vim.cmd.colorscheme("omarchy")

		-- Then
		local got = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Boolean" }).fg)
		local want = "#b36d43"
		assert(got == want, "got:" .. got .. ",want:" .. want)
	end,
}
