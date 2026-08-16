# Omarchy Theme Loader 🎨

A drop-in plugin for changing Neovim theme automatically when Omarchy theme changes.

## Installation

<details>
<summary>vim.pack setup</summary>
<br/>
<p>
Add this to your init.lua file and you are good to go.
</p>

```lua
vim.pack.add({
    -- 1. Install theme plugins
    "https://github.com/neanias/everforest-nvim",
    "https://github.com/kepano/flexoki-neovim",
    "https://github.com/ellisonleao/gruvbox.nvim",
    "https://github.com/bjarneo/aether.nvim",
    "https://github.com/bjarneo/hackerman.nvim",
    "https://github.com/rebelot/kanagawa.nvim",
    "https://github.com/omacom-io/lumon.nvim",
    "https://github.com/tahayvr/matteblack.nvim",
    "https://github.com/EdenEast/nightfox.nvim",
    "https://github.com/ribru17/bamboo.nvim",
    "https://github.com/OldJobobo/retro-82.nvim",
    "https://github.com/ficcdaf/ashen.nvim",
    "https://github.com/folke/tokyonight.nvim",
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    { src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
    -- 2. Install omarchy-theme-loader.nvim
	"https://github.com/EskelinenAntti/omarchy-theme-loader.nvim"
})
```

</details>
<details>
<summary>lazy.nvim setup</summary>
<br/>
<p>
Add this to your plugins folder and you are good to go.
</p>

```lua
return {
    -- 1. Install theme plugins
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},
	"neanias/everforest-nvim",
	"flexoki-light/neovim.lua",
	"kepano/flexoki-neovim",
	"ellisonleao/gruvbox.nvim",
	{
		"bjarneo/hackerman.nvim",
		dependencies = { "bjarneo/aether.nvim" },
	},
	"rebelot/kanagawa.nvim",
	"omacom-io/lumon.nvim",
	"tahayvr/matteblack.nvim",
	"EdenEast/nightfox.nvim",
	"ribru17/bamboo.nvim",
	"OldJobobo/retro-82.nvim",
	{ "rose-pine/neovim", name = "rose-pine" },
	"ficcdaf/ashen.nvim",
	"folke/tokyonight.nvim",
    -- 2. Install omarchy-theme-loader.nvim
	"EskelinenAntti/omarchy-theme-loader.nvim"
}
```
</details>


<details>

<summary>Other plugin managers and manual installation</summary>  
<br/>
<p>
To use
<ol>
    <li>Install the Neovim plugins for Omarchy themes (you can find the list of default theme plugins from above examples).</li>
    <li>Install the `EskelinenAntti/omarchy-theme-loader.nvim` plugin.</li>
</ol>
</p>

</details>


## Advanced configuration

### Custom Omarchy themes

If you use a custom Omarchy theme
1. Install the Neovim plugin for that theme.
2. Configure the mapping between Omarchy theme name and Neovim colorscheme.

The examples below shows how to configure `omarchy-theme-loader` to work with the <a href="https://github.com/bjarneo/omarchy-ash-theme">Omarchy Ash Theme</a>.

<details>

<summary>vim.pack example</summary>

```lua
vim.pack.add({
    -- 1. Install the theme plugin
    "https://github.com/bjarneo/ash.nvim",
    -- ... other themes
})

-- 2. Configure required mapping between Omarchy theme name and Neovim colorscheme.
require("omarchy-theme-loader").setup({
    themes = {
        -- Name of the Omarchy theme.
        ["ash"] = {
            -- Name of the corresponding Neovim colorscheme.
            colorscheme = "ash"
        }
    }
})
```

</details>

<details>
<summary>lazy.nvim example</summary>


```lua
return {
    -- 1. Install the theme plugin.
    {
        "bjarneo/ash.nvim"
    },
    -- ... other themes

    -- 2. Configure required mapping between Omarchy theme name and Neovim colorscheme.
	{
		"EskelinenAntti/omarchy-theme-loader.nvim",
        opts = {
            themes = {
                -- Name of the Omarchy theme.
                ["ash"] = {
                    -- Name of the corresponding Neovim colorscheme.
                    colorscheme = "ash"
                }
            }
        }

	},
```

</details>


Don't know where to look for the plugin or the colorscheme? You can find those from the custom Omarchy theme's repository, from `neovim.lua` file.

For example, see the [neovim.lua](https://github.com/bjarneo/omarchy-ash-theme/blob/main/neovim.lua) file for the Omarchy Ash Theme: the Neovim plugin is `bjarneo/ash.nvim` and the colorscheme is `ash`.

### Overriding Omarchy's default themes

Your are not forced to use the same Neovim themes as Omarchy uses by default.

For example, if you want to keep your Neovim setup minimal and don't want to install lot's of theme plugins, you can override omarchy-theme-loader's configuration to use Neovim's builtin themes.

<details>
<summary>lazy.nvim example</summary>


```lua
return {
	{
		"EskelinenAntti/omarchy-theme-loader.nvim",
        opts = {
            themes = {
                ["tokyo-night"] = { colorscheme = "slate" },
                ["catppuccin"] = { colorscheme = "blue" },
                ["everforest"] = { colorscheme = "desert" },
                ["gruvbox"] = { colorscheme = "retrobox" },
                ["osaka-jade"] = { colorscheme = "slate" },
                ["kanagawa"] = { colorscheme = "slate" },
                ["nord"] = { colorscheme = "blue" },
                ["matte-black"] = { colorscheme = "koehler" },
                ["ristretto"] = { colorscheme = "koehler" },
                ["flexoki-light"] = { colorscheme = "morning" },
                ["rose-pine"] = { colorscheme = "morning" },
                ["catppuccin-latte"] = { colorscheme = "delek" },
            }
        }

	},
```

</details>

<details>

<summary>mini.deps example</summary>

```lua
local add = MiniDeps.add

add("EskelinenAntti/omarchy-theme-loader.nvim")
require("omarchy-theme-loader").setup({
    themes = {
		["tokyo-night"] = { colorscheme = "slate" },
		["catppuccin"] = { colorscheme = "blue" },
		["everforest"] = { colorscheme = "desert" },
		["gruvbox"] = { colorscheme = "retrobox" },
		["osaka-jade"] = { colorscheme = "slate" },
		["kanagawa"] = { colorscheme = "slate" },
		["nord"] = { colorscheme = "blue" },
		["matte-black"] = { colorscheme = "koehler" },
		["ristretto"] = { colorscheme = "koehler" },
		["flexoki-light"] = { colorscheme = "morning" },
		["rose-pine"] = { colorscheme = "morning" },
		["catppuccin-latte"] = { colorscheme = "delek" },
    }
})
```

</details>

### Other OSs

The plugin only activates when it detects the Omarchy theme folder at `~/.config/omarchy/current/theme`. You can safely include it in your Neovim configuration, even if you shared it between multiple devices.

To specify a theme to be used in non-Omarchy environments, you can simply do

```lua
vim.cmd.colorscheme("retrobox") -- or whatever theme or colorscheme you prefer to use outside of Omarchy
```

This setting will apply in non-Omarchy environments. When in Omarchy, the omarchy-theme-loader will overwrite it with the current Omarchy theme.

