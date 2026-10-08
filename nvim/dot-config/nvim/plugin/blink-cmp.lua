-- ~/.config/nvim/plugin/blink-cmp.lua | Curtis Free (https://curtisfree.com)

-- Install {{{
vim.pack.add({
  {
    src = "https://github.com/saghen/blink.cmp",
    name = "blink",
    version = vim.version.range("v1.x"),
  },
})
-- }}}

-- Configure {{{
require("blink.cmp").setup({
  keymap = {
    preset = "enter",
  },
  signature = {
    enabled = true,
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 150,
    },
    list = {
      selection = {
        preselect = false,
      },
    },
    menu = {
      auto_show = true,
      draw = {
        treesitter = {
          "lsp",
        },
      },
    },
    ghost_text = {
      enabled = true,
      show_with_menu = true,
    },
  },
  fuzzy = {
    -- rust may be faster, but I'd rather not download the binary
    implementation = "lua",
  },
  sources = {
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
    },
  },
})
-- }}}
