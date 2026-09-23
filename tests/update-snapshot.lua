local file = assert(io.open("tests/snapshots/highlights.txt", "w"))
local snapshot = require("tests.snapshot")
file:write(snapshot.snapshot())
file:close()
