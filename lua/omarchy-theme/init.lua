local M = {}

M.name = "omarchy"

function M.apply()
	if not require("omarchy-theme.environment").is_omarchy() then
		vim.notify(
			"Tried to apply `omarchy` colorscheme outside of Omarchy.\n\n"
				.. "To specify a theme to be used in non-Omarchy environments, add below lines to your Neovim configuration:\n"
				.. "```lua\n"
				.. 'if require("omarchy-theme.environment").is_omarchy() then\n'
				.. '  vim.cmd.colorscheme("omarchy")\n'
				.. "else\n"
				.. '  vim.cmd.colorscheme("default")\n'
				.. "end\n"
				.. "```",
			vim.log.levels.WARN
		)
		return
	end

	local toml = require("omarchy-theme.toml-parser").parse_file(
		require("omarchy-theme.environment").omarchy_current_theme_colors_path
	)

	if not toml then
		vim.notify(string.format("Could not load Omarchy theme colors."), vim.log.levels.ERROR)
		return
	end

	local palette = require("omarchy-theme.palette").palette_for(toml)
	local highlights = require("omarchy-theme.highlighter").highlights_for(palette)

	vim.cmd.hi("clear")
	vim.g.colors_name = M.name

	-- Apply highlight groups
	for group, hl in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, hl)
	end
end

return M
