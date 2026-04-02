-- ~/.config/nvim/lua/plugins/spec/blink-cmp.lua | Curtis Free (https://curtisfree.com)

return {
  "saghen/blink.cmp",
  version = "1.*",
  opts = {
    keymap = {
      preset = "enter",
    },
    signature = {
      enabled = true,
    },
    completion = {
      documentation = {
        auto_show = false,
        auto_show_delay_ms = 500,
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
        show_with_menu = false,
      },
    },
    fuzzy = {
      -- rust may be faster, but I'd rather not download the binary
      implementation = "lua",
    },
    sources = {
      -- no "buffer"
      default = {
        "lsp",
        "path",
        "snippets",
      },
    },
  },
}
