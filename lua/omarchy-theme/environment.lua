local M = {}

M.omarchy_current_theme_name_path = vim.fs.joinpath(vim.env.HOME, ".local", "state", "omarchy", "current", "theme.name")
M.omarchy_current_theme_colors_path =
	vim.fs.joinpath(vim.env.HOME, ".local", "state", "omarchy", "current", "theme", "colors.toml")

M.is_omarchy = function()
	return vim.uv.fs_stat(M.omarchy_current_theme_name_path) ~= nil
end

return M
