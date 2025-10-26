-- ~/.config/nvim/lua/plugins/spec/fzf.lua | Curtis Free (https://curtisfree.com)

return {
  "junegunn/fzf.vim",
  name = "fzf",
  enabled = function()
    -- https://www.reddit.com/r/neovim/comments/sfg1wl/comment/hupi92q/
    return vim.fn.executable("fzf") == 1
  end,
  dependencies = {
    "junegunn/fzf",
    name = "fzf-core",
  },
  init = function()
    vim.keymap.set("n", "<C-p>", ":Files<CR>")
  end,
}
