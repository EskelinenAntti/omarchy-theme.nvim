local M = {}

---Sync Neovim theme to the current Omarchy theme.
local function sync_theme()
	if vim.g.colors_name ~= require("omarchy-theme").name then
		return
	end
	require("omarchy-theme").apply()
end

---Sync the Neovim theme to current Omarchy theme, and start watching for Omarchy theme changes.
---
---Do not call this directly from your Neovim config; Neovim will call it automatically on startup via
---`after/plugin/omarchy-theme-loader.lua`.
M.start = function()
	if not require("omarchy-theme.environment").is_omarchy() then
		return
	end

	local fs_event, err = vim.uv.new_fs_event()
	if err or not fs_event then
		vim.notify(string.format("Could not start listening for Omarchy theme changes: %s", err), vim.log.levels.ERROR)
		return
	end

	local cooldown
	vim.uv.fs_event_start(fs_event, require("omarchy-theme.environment").omarchy_current_theme_name_path, {}, function()
		if cooldown and cooldown:is_active() then
			return
		end

		cooldown = vim.defer_fn(
			-- vim.cmd.* commands must not be called in fast event context, so defer it to be invoked soon by the main event loop.
			vim.schedule_wrap(function()
				sync_theme()
			end),
			100
		)
	end)
end

return M
