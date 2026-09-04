local M = {}

---Parse simple toml into table.
---@param toml string
---@return table<string, string>
function M.parse(toml)
	local result = {}

	for line in toml:gmatch("[^\r\n]+") do
		local key, value = line:match('^%s*([%w_%-]+)%s*=%s*"(.-)"%s*$')

		if key then
			result[key] = value
		end
	end

	return result
end

---Parse simple toml file into table.
---@param path string Path to file
---@return table<string, string>?
function M.parse_file(path)
	if vim.fn.filereadable(path) ~= 1 then
		return nil
	end

	local file, _ = io.open(path, "r")
	if not file then
		return nil
	end

	local text = file:read("*a")
	file:close()

	return M.parse(text)
end

return M
