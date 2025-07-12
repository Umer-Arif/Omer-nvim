vim.keymap.set({'n', 'i'}, '<C-s>', function()
  vim.cmd('write')
end, { desc = "Save current file" })

-- telescope :
-- vim.keymap.set("n", "<leader>ff", function()
-- ~/.config/nvim/lua/config/keymaps.lua
vim.keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files({
    cwd = vim.fn.expand("$HOME"), -- Search home directory
    hidden = true,
    find_command = { "fd", "--hidden", "--exclude", ".git" },
  })
end, { desc = "Find files including dotfiles in $HOME" })
