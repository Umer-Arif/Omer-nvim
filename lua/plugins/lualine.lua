-- lua/plugins/lualine.lua
return {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- This 'config' function runs AFTER the plugin is loaded by Lazy.nvim
    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'auto', -- 'auto' will try to pick based on your colorscheme
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true, -- If you want the tabline always visible
                globalstatus = false, -- Set to true to have a single statusline for all windows
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                    refresh_time = 16, -- ~60fps
                    events = {
                        'WinEnter',
                        'BufEnter',
                        'BufWritePost',
                        'SessionLoadPost',
                        'FileChangedShellPost',
                        'VimResized',
                        'Filetype',
                        'CursorMoved',
                        'CursorMovedI',
                        'ModeChanged',
                    },
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {}, -- Empty table means no tabline, or configure it here
            winbar = {}, -- Empty table means no winbar, or configure it here
            inactive_winbar = {},
            extensions = {}
        }
    end,
    -- You can add `event = "VeryLazy"` to lazily load it, if desired.
    -- event = "VeryLazy",
}
