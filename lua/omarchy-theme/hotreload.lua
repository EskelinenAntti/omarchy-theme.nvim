---@type userdata|nil
local handle

---Sync Neovim theme to the current Omarchy theme.
local function sync_theme()
	if vim.g.colors_name ~= require("omarchy-theme").name then
		return
	end
	require("omarchy-theme").apply()
end

local M = {}

---Sync the Neovim theme to current Omarchy theme, and start watching for Omarchy theme changes.
---
---Do not call this directly from your Neovim config; Neovim will call it automatically on startup via
---`after/plugin/omarchy-theme-loader.lua`.
M.start = function()
	if not require("omarchy-theme.environment").is_omarchy() then
		return
	end

	if handle then
		return
	end

	local err
	handle, err = vim.uv.new_fs_event()
	if err or not handle then
		vim.notify(string.format("Could not start listening for Omarchy theme changes: %s", err), vim.log.levels.ERROR)
		return
	end

	-- Watching the current/theme.name file instead of current/theme/colors.toml works better for some reason. If trying to watch the
	-- latter file, the watcher stops receiving events after 1 or two theme changes. This could be due to Omarchy replacing the whole
	-- current/theme folder.
	vim.uv.fs_event_start(handle, require("omarchy-theme.environment").omarchy_current_theme_name_path, {}, function()
		-- vim.cmd.* commands must not be called in fast event context, so defer it to be invoked soon by the main event loop.
		vim.schedule(function()
			sync_theme()
		end)
	end)
end

return M
