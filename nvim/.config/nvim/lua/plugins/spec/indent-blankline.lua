-- ~/.config/nvim/lua/plugins/spec/indent-blankline.lua | Curtis Free (https://curtisfree.com)

return {
  "lukas-reineke/indent-blankline.nvim",
  name = "indent-blankline",
  main = "ibl",
  opts = {
    indent = {
      smart_indent_cap = false,
    },
  },
}
