-- ~/.config/nvim/plugin/tiny-inline-diagnostics.lua | Curtis Free (https://curtisfree.com)

-- Install {{{
vim.pack.add({
  {
    src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
    name = "tiny-inline-diagnostics",
  },
})
-- }}}

-- Configure {{{
do
  -- Set background highlight style
  require("tiny-inline-diagnostic").setup({
    preset = "powerline",
  })

  -- Configure how Neovim should surface diagnostics
  vim.diagnostic.config({
    virtual_text = false,
    -- Match tiny-inline-diagnostic signs
    -- ▶︎ See https://vi.stackexchange.com/a/46839
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "●",
        [vim.diagnostic.severity.WARN] = "●",
        [vim.diagnostic.severity.HINT] = "●",
        [vim.diagnostic.severity.INFO] = "●",
      },
    },
  })
end
-- }}}
