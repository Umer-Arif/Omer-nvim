return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- optional config here
    default_file_explorer = true, -- replace netrw (optional)
    view_options = {
      show_hidden = true,
    },
  },
  keys = {
    { "<leader>o", "<cmd>Oil<CR>", desc = "Open parent directory (Oil)" },
  },
  cmd = { "Oil" },
}

