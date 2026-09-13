local M = {}

local function highlights(colors_path, theme_name_path)
	local env = require("omarchy-theme.environment")
	env.omarchy_current_theme_colors_path = colors_path
	env.omarchy_current_theme_name_path = theme_name_path

	vim.cmd.colorscheme("omarchy")
	return vim.api.nvim_get_hl(0, {})
end

function M.highlights()
	return highlights("tests/current/theme/colors.toml", "tests/current/theme.name")
end

function M.highlights_without_omarchy()
	return highlights("tests/not-existing/theme/colors.toml", "tests/not-existing/theme.name")
end

function M.snapshot()
	return vim.inspect(M.highlights(), { sort_keys = true }) .. "\n"
end

function M.snapshot_without_omarchy()
	return vim.inspect(M.highlights_without_omarchy(), { sort_keys = true }) .. "\n"
end

return M
