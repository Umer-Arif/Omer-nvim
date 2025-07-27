return {
    "echasnovski/mini.statusline",
    enabled = false,
    version = false,
    lazy = false,
    config = function()
        require("mini.statusline").setup({
            use_icons = true,        -- or false if you want no icons
            set_vim_settings = true, -- auto set `laststatus=2`
        })
    end,
}
