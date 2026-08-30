local M = {}

M.omarchy_current_theme_name_path = vim.fs.joinpath(vim.env.HOME, ".local", "state", "omarchy", "current", "theme.name")
M.omarchy_current_theme_colors_path =
	vim.fs.joinpath(vim.env.HOME, ".local", "state", "omarchy", "current", "theme", "colors.toml")

local is_omarchy = nil
M.is_omarchy = function()
	if is_omarchy == nil then
		is_omarchy = vim.uv.fs_stat(M.omarchy_current_theme_name_path) ~= nil
	end

	return is_omarchy
end

return M
