local function assert_snapshot(path, snapshot)
	local file = assert(io.open(path, "r"))
	local want = file:read("*a")
	file:close()

	local got = snapshot()
	assert(got == want, "highlight snapshot differs\n\nExpected:\n" .. want .. "\nGot:\n" .. got)
end

return {
	["Highlight definitions match the snapshot"] = function()
		assert_snapshot("tests/snapshots/highlights.txt", require("tests.snapshot").snapshot)
	end,
}
