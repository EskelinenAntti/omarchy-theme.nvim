local function get_test_files()
	local files = {}

	for name, type in vim.fs.dir("tests") do
		if type == "file" and name:match("^test.*%.lua$") then
			table.insert(files, name)
		end
	end

	return files
end

for _, file in ipairs(get_test_files()) do
	local module = "tests." .. file:gsub("%.lua$", "")
	local tests = require(module)
	print(("\n-- %s --\n"):format(file))

	for name, test in pairs(tests) do
		local ok, err = pcall(test)

		if not ok then
			io.stderr:write(("FAIL %s\n%s\n"):format(name, err))
			os.exit(1)
		end

		print(("PASS %s\n"):format(name))
	end
end
