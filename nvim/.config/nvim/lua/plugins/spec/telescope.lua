-- ~/.config/nvim/lua/plugins/spec/fzf.lua | Curtis Free (https://curtisfree.com)

return {
  "nvim-telescope/telescope.nvim",
  name = "telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    name = "plenary",
  },
  init = function()
    -- keymaps (when to use Telescope)
    vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>")
    vim.keymap.set("n", "<C-A-p>", ":Telescope live_grep<CR>")
    vim.keymap.set("n", ";", ":Telescope buffers<CR>")

    -- Telescope settings
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<Esc>"] = require("telescope.actions").close,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
          },
        },
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        layout_config = {
          anchor_padding = 5,
          prompt_position = "top",
        },
      },
      pickers = {
        buffers = {
          layout_strategy = "vertical",
          layout_config = {
            width = 0.40,
            height = 0.50,
          },
          previewer = false,
          prompt_title = "Buffer(s)",
          results_title = "",
        },
        find_files = {
          preview_title = "Preview",
          prompt_title = "Search (Filenames)",
          results_title = "Matches",
        },
        live_grep = {
          preview_title = "Preview",
          prompt_title = "Search (Contents)",
          results_title = "Matches",
        },
      },
    })
  end,
}
