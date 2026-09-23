test:
	nvim --headless --clean -c "set rtp+=." -l tests/init.lua

snapshot:
	nvim --headless --clean -c "set rtp+=." -l tests/update-snapshot.lua
