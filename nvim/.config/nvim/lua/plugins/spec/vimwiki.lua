-- ~/.config/nvim/lua/plugins/spec/vimwiki.lua | Curtis Free (https://curtisfree.com)

return {
  "vimwiki/vimwiki",
  name = "vimwiki",
  init = function()
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
  end,
}
