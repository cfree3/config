-- ~/.config/nvim/plugin/vimwiki.lua | Curtis Free (https://curtisfree.com)

-- Configure {{{
-- ▶︎ Before install, per https://vi.stackexchange.com/a/43447
do
  vim.g.vimwiki_global_ext = 0
  vim.g.vimwiki_list = {
    {
      name = "Notes",
      path = "~/Notes",
      syntax = "markdown",
      ext = "md",
      diary_rel_path = "Today/",
      diary_header = "Timeline",
      auto_diary_index = 1,
    },
  }
end
-- }}}

-- Install {{{
vim.pack.add({
  {
    src = "https://github.com/vimwiki/vimwiki",
    name = "vimwiki",
  },
})
-- }}}
