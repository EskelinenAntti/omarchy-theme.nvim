test:
	nvim --headless --clean -c "set rtp+=." -l tests/init.lua

snapshot:
	UPDATE_SNAPSHOTS=1 nvim --headless --clean -c "set rtp+=." -l tests/init.lua
