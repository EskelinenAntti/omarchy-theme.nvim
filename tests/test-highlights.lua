local original_termguicolors

local function assert_snapshot(path, snapshot)
	local file = assert(io.open(path, "r"))
	local want = file:read("*a")
	file:close()

	local got = snapshot()
	assert(got == want, "highlight snapshot differs\n\nExpected:\n" .. want .. "\nGot:\n" .. got)
end

return {
	before = function()
		original_termguicolors = vim.o.termguicolors
	end,
	after = function()
		vim.opt.termguicolors = original_termguicolors
	end,

	["Highlight definitions match the snapshot"] = function()
		assert_snapshot("tests/snapshots/highlights.txt", require("tests.snapshot").snapshot)
	end,

	["ANSI highlight definitions outside Omarchy match the snapshot"] = function()
		vim.opt.termguicolors = false
		assert_snapshot(
			"tests/snapshots/ansi-highlights.txt",
			require("tests.snapshot").snapshot_without_omarchy
		)
	end,
}
