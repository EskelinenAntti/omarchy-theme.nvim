local M = {}

function M.highlights()
	local env = require("omarchy-theme.environment")
	env.omarchy_current_theme_colors_path = "tests/current/theme/colors.toml"
	env.omarchy_current_theme_name_path = "tests/current/theme.name"

	vim.cmd.colorscheme("omarchy")
	return vim.api.nvim_get_hl(0, {})
end

function M.snapshot()
	return vim.inspect(M.highlights(), { sort_keys = true }) .. "\n"
end

return M
