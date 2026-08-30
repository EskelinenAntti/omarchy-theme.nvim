local M = {}

M.name = "omarchy"

function M.apply()
	if not require("omarchy-theme.environment").is_omarchy() then
		return
	end

	local palette = require("omarchy-theme.toml-parser").parse_file(
		require("omarchy-theme.environment").omarchy_current_theme_colors_path
	)

	if not palette then
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
