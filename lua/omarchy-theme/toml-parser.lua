local M = {}

function M.parse(text)
	local result = {}

	for line in text:gmatch("[^\r\n]+") do
		local key, value = line:match('^%s*([%w_%-]+)%s*=%s*"(.-)"%s*$')

		if key then
			result[key] = value
		end
	end

	return result
end

function M.parse_file(path)
	if vim.fn.filereadable(path) ~= 1 then
		return nil
	end

	local file, err = io.open(path, "r")
	if not file then
		return nil, err
	end

	local text = file:read("*a")
	file:close()

	return M.parse(text)
end

return M
