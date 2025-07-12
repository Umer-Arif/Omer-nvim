-- lua/plugins/bufferline.lua
return {
  {
    "akinsho/bufferline.nvim",
    tag = "v4.9.1", -- <-- Add this line explicitly
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("bufferline").setup({})
    end,
  },
}
