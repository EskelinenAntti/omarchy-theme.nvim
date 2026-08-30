# omarchy-theme.nvim 🎨

A standalone Neovim colorscheme plugin that automatically syncs with the active Omarchy theme.

https://github.com/user-attachments/assets/133dadfc-98d8-44a4-95a2-d3f7c6026313

Main features:
- Minimal footprint: no need to install any 3rd party theme plugins separately.
- Supports custom Omarchy themes out-of-the-box. No additional configuration needed.
- Works with any plugin manager.

## Supported Omarchy versions

The latest version of this plugin (since v2.0.0) works only with Omarchy v4 or later.

<details>
    <summary>Migrating from plugin version v1 to v2 (or later)</summary>
    <br/>
    <p>
    Follow these steps:
    <ol>
        <li>Delete all other theme dependencies.</li>
        <li>Set colorscheme to "omarchy" with <code>vim.cmd.colorscheme("omarchy")</code></li>
    </ol>
    </p>
</details>

## Installation with vim.pack (Neovim built-in plugin manager)

Add these two lines to your init.lua file and you are good to go.

```lua
vim.pack.add({"https://github.com/EskelinenAntti/omarchy-theme.nvim"})
vim.cmd.colorscheme("omarchy")
```

<details>
    <summary>Other plugin managers and manual installation</summary>  
    <br/>
    <p>
    To use the plugin
    <ol>
        <li>Install the `EskelinenAntti/omarchy-theme.nvim` plugin following the usual steps of your chosen plugin manager</li>
        <li>Set colorscheme to "omarchy" with `vim.cmd.colorscheme("omarchy")`</li>
    </ol>
    </p>
</details>

### Other OSs

The plugin only activates when it detects the Omarchy theme folder at `~/.config/omarchy/current/theme`. You can safely include it in your Neovim configuration, even if you shared it between multiple devices.

To specify a theme to be used in non-Omarchy environments, you can simply do

```lua
if (require("omarchy-theme.environment").is_omarchy()) then
    vim.cmd.colorscheme("omarchy")
else
    vim.cmd.colorscheme("retrobox") -- or whatever theme or colorscheme you prefer to use outside of Omarchy
end
```

