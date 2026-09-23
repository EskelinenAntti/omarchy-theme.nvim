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
	local before = tests.before or function() end
	local after = tests.after or function() end
	tests.before = nil
	tests.after = nil

	for name, test in pairs(tests) do
		local ok, err = pcall(function()
			before()
			test()
		end)

		local after_ok, after_err = pcall(after)
		if not after_ok then
			ok = false
			err = err or after_err
		end

		if not ok then
			io.stderr:write(("FAIL %s\n%s\n"):format(name, err))
			os.exit(1)
		end

		print(("PASS %s\n"):format(name))
	end
end
