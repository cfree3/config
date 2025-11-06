-- ~/.config/nvim/lua/plugins/spec/telescope.lua | Curtis Free (https://curtisfree.com)

return {
  "nvim-telescope/telescope.nvim",
  name = "telescope",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      name = "plenary",
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      name = "telescope-fzf",
      build = "make",
    },
  },
  config = function()
    -- Keymaps (when to use Telescope)
    vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>")
    vim.keymap.set("n", "<C-A-p>", ":Telescope live_grep<CR>")
    -- ▶︎ See https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
    vim.keymap.set("n", "<C-S-p>", ':lua require("telescope.builtin").resume()<CR>')
    vim.keymap.set("n", ";", ":Telescope buffers<CR>")

    -- Settings
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

    -- Extensions
    -- ▶︎ Use native FZF to find files by name (more capable than builtin)
    --   ▶︎ See https://www.reddit.com/r/neovim/comments/1fk4r04/comment/lnt77pj/
    require("telescope").load_extension("fzf")
  end,
}
