return {
	---Map raw colors from colors.toml into Palette.
	---@param toml table<string, string> Raw colors from colors.toml
	---@return Palette
	palette_for = function(toml)
		local palette = vim.deepcopy(toml)
		palette.orange = palette.orange or palette.yellow
		return palette
	end,
}
