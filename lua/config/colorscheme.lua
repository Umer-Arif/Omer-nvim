-- lua/plugins/colorscheme.lua
-- No plugin spec, just a Lua module
vim.defer_fn(function()
    vim.cmd [[colorscheme kanagawa]]
end, 50)
