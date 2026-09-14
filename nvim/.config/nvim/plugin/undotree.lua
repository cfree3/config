-- ~/.config/nvim/plugin/undotree.lua | Curtis Free (https://curtisfree.com)

-- Install {{{
vim.cmd.packadd("nvim.undotree")
-- }}}

-- Configure {{{
-- ▶︎ UndoTree
--   ▶︎ Open the undo tree
vim.api.nvim_create_user_command("UndoTree", function()
  require("undotree").open()
end, {})
-- }}}
