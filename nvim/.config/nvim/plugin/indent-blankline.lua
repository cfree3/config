-- ~/.config/nvim/plugin/indent-blankline.lua | Curtis Free (https://curtisfree.com)

-- Install {{{
vim.pack.add({
  {
    src = "https://github.com/lukas-reineke/indent-blankline.nvim",
    name = "indent-blankline",
  },
})
-- }}}

-- Configure {{{
require("ibl").setup({
  indent = {
    smart_indent_cap = false,
  },
})
-- }}}
