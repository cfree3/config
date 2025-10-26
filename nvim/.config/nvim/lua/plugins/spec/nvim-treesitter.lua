-- ~/.config/nvim/lua/plugins/spec/nvim-treesitter.lua | Curtis Free (https://curtisfree.com)

return {
  "nvim-treesitter/nvim-treesitter",
  name = "nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
}
