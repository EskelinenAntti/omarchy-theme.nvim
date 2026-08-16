local opts = require("omarchy-theme-loader.default-opts")

local omarchy_v4_current_path = vim.fs.joinpath(vim.env.HOME, ".local", "state", "omarchy", "current")
local omarchy_v3_current_path = vim.fs.joinpath(vim.env.HOME, ".config", "omarchy", "current")

---@type userdata|nil
local handle

--- Configuration for a single theme.
---@class Theme
---@field colorscheme string The colorscheme name.

--- Options for configuing Omarchy themes.
---@class Opts
---@field themes table<string, Theme> A map of Omarchy theme names to their corresponding Neovim configurations.

---@class ModernEnvironment
---@field omarchy_current_path string Path to the folder containing info on currently active theme.
---@field version "~3.3"|">=4" Omarchy version
---@field omarchy_current_theme_name_path string Path to file containing current theme name if exists.

---@class LegacyEnvironment
---@field omarchy_current_path string Path to the folder containing info on currently active theme.
---@field version "<3.3" Omarchy version

---Information on Omarchy environment.
---@alias Environment ModernEnvironment|LegacyEnvironment

---Returns information from current environment
---@return Environment|nil
local function check_environment()
	local config = {}

	if vim.uv.fs_stat(omarchy_v4_current_path) ~= nil then
		config.omarchy_current_path = omarchy_v4_current_path
	elseif vim.uv.fs_stat(omarchy_v3_current_path) ~= nil then
		config.omarchy_current_path = omarchy_v3_current_path
	else
		return nil
	end

	local omarchy_current_theme_name_path = vim.fs.joinpath(config.omarchy_current_path, "theme.name")
	if vim.uv.fs_stat(omarchy_current_theme_name_path) then
		config.omarchy_current_theme_name_path = omarchy_current_theme_name_path
	end

	if config.omarchy_current_path == omarchy_v4_current_path then
		config.version = ">=4"
	elseif config.omarchy_current_theme_name_path ~= nil then
		config.version = "~3.3"
	else
		config.version = "<3.3"
	end

	return config
end

---Get name of currently active Omarchy theme.
---@param config Environment
---@return string
local function current_omarchy_theme_name(config)
	if config.version == "<3.3" then
		local symlink = config.omarchy_current_path .. "/theme"
		local resolved = vim.fn.resolve(symlink)
		return vim.fn.fnamemodify(resolved, ":t")
	end

	-- Read theme name from 'theme.name' file
	local file = io.open(assert(config.omarchy_current_theme_name_path), "r")
	if not file then
		error(string.format("Could not read current theme from '%s'", config.omarchy_current_theme_name_path))
	end

	local theme = file:read()
	file:close()
	return theme
end

---Sync Neovim theme to the current Omarchy theme.
---@param config Environment
local function sync_theme(config)
	local ok, omarchy_theme_result = pcall(current_omarchy_theme_name, config)
	if not ok then
		vim.notify(omarchy_theme_result, vim.log.levels.ERROR)
		return
	end

	local theme = opts.themes[omarchy_theme_result]
	if not theme then
		vim.notify(
			string.format(
				"Did not find Neovim theme for Omarchy theme '%s'. You can specify it via your omarchy-theme-loader configuration.",
				omarchy_theme_result
			),
			vim.log.levels.ERROR
		)
		return
	end

	-- Reset background option to its default.
	vim.o.background = "dark"

	-- Enable the actual theme.
	if not pcall(vim.cmd.colorscheme, theme.colorscheme) then
		vim.notify(
			string.format(
				"Did not find colorscheme %s. You might need to install a Neovim plugin that specifies the colorscheme.",
				theme.colorscheme
			)
		)
		return
	end

	-- Set background to be transparent.
	require("omarchy-theme-loader.transparency").set_transparent_background()
end

local M = {}

---@param user_opts Opts|nil
M.setup = function(user_opts)
	-- Combine user config with defaults.
	opts = vim.tbl_deep_extend("force", opts, user_opts or {})
end

---Sync the Neovim theme to current Omarchy theme, and start watching for Omarchy theme changes.
---
---Do not call this directly from your Neovim config; Neovim will call it automatically on startup via
---`after/plugin/omarchy-theme-loader.lua`.
M.start = function()
	local config = check_environment()
	if config == nil then
		return
	end

	-- Sync the theme at startup.
	sync_theme(config)

	if handle then
		return
	end

	local err
	handle, err = vim.uv.new_fs_event()
	if err or not handle then
		vim.notify(string.format("Could not start listening for Omarchy theme changes: %s", err), vim.log.levels.ERROR)
		return
	end

	if config.version == "<3.3" then
		vim.uv.fs_event_start(handle, config.omarchy_current_path, {}, function(_, filename, _)
			-- In older Omarchy versions we needed to listen for theme changes by watching the .config/omarchy/current folder,
			-- and only react to updates in the 'theme' symlink within the folder.
			if filename ~= "theme" then
				return
			end

			-- vim.cmd.* commands must not be called in fast event context, so defer it to be invoked soon by the main event loop.
			vim.schedule(function()
				sync_theme(config)
			end)
		end)
	else
		-- Watch 'theme.name' file and sync Neovim whenever there is an update.
		vim.uv.fs_event_start(handle, config.omarchy_current_theme_name_path, {}, function(_, _, _)
			-- vim.cmd.* commands must not be called in fast event context, so defer it to be invoked soon by the main event loop.
			vim.schedule(function()
				sync_theme(config)
			end)
		end)
	end
end

return M
