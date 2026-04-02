-- ~/.config/nvim/plugin/nvim-treesitter.lua | Curtis Free (https://curtisfree.com)

-- Update {{{
-- ▶︎ From https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    local plugin = event.data.spec.name
    local action = event.data.kind
    if plugin == "nvim-treesitter" and action == "update" then
      if not event.data.active then
        vim.cmd.packadd(plugin)
      end
      vim.cmd("TSUpdate")
    end
  end,
})
-- }}}

-- Install Plugin {{{
vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    name = "nvim-treesitter",
    version = "main",
  },
})
-- }}}

-- Install Parsers {{{
require("nvim-treesitter").install({
  "lua",
  "zsh",
})
-- }}}
