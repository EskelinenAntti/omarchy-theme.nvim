local file = assert(io.open("tests/snapshots/highlights.txt", "w"))
local snapshot = require("tests.snapshot")
file:write(snapshot.snapshot())
file:close()

local file = assert(io.open("tests/snapshots/ansi-highlights.txt", "w"))
file:write(snapshot.snapshot_without_omarchy())
file:close()
