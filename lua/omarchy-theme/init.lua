local M = {}

M.name = "omarchy"

function M.apply()
	if not require("omarchy-theme.environment").is_omarchy() then
		vim.notify(
			string.format("Omarchy theme configuration was not found. `omarchy` colorscheme has no effect."),
			vim.log.levels.WARN
		)
		return
	end

	local palette = require("omarchy-theme.toml-parser").parse_file(
		require("omarchy-theme.environment").omarchy_current_theme_colors_path
	)

	if not palette then
		vim.notify(string.format("Could not load Omarchy theme colors."), vim.log.levels.ERROR)
		return
	end

	local highlights = require("omarchy-theme.highlighter").highlights_for(palette)

	vim.cmd.hi("clear")
	vim.g.colors_name = M.name

	-- Apply highlight groups
	for group, hl in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, hl)
	end
end

return M
