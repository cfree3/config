-- ~/.config/nvim/plugin/snacks.lua | Curtis Free (https://curtisfree.com)

-- Install {{{
vim.pack.add({
  {
    src = "https://github.com/folke/snacks.nvim",
    name = "snacks",
  },
})
-- }}}

-- Configure {{{
do
  local Snacks = require("snacks")
  Snacks.setup({
    styles = {
      dashboard = {
        wo = {
          fillchars = "eob: ",
        },
      },
    },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { section = "keys", title = "󰌓 Shortcuts", padding = 1 },
        { section = "recent_files", title = "󱫙 Recent Files" },
      },
      preset = {
        keys = {
          { icon = "", key = "i", desc = "New File", action = ":enew | startinsert" },
          { icon = "󰧑", key = "p", desc = "Smart Search", action = ":lua Snacks.dashboard.pick('smart')" },
          { icon = "", key = "f", desc = "Search (Filenames)", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = "", key = "g", desc = "Search (Content)", action = ":lua Snacks.dashboard.pick('grep')" },
          { icon = "󰠮", key = "t", desc = "Open Today's Vimwiki Entry", action = ":VimwikiMakeDiaryNote" },
          { icon = "", key = "e", desc = "Explore", action = ":lua Snacks.dashboard.pick('explorer')" },
          { icon = "", key = "q", desc = "Quit", action = ":qall" },
        },
      },
      formats = {
        title = { "%s\n", align = "center" },
      },
    },
    explorer = {
      enabled = true,
      replace_netrw = false,
    },
    image = {
      enabled = true,
      doc = {
        float = true,
        inline = false,
      },
    },
    indent = {
      enabled = true,
      animate = {
        enabled = false,
      },
      chunk = {
        enabled = true,
        hl = "Directory",
        char = {
          corner_top = "╭",
          corner_bottom = "╰",
          arrow = "─",
        },
      },
      scope = {
        hl = "Directory",
      },
    },
    picker = {
      enabled = true,
      sources = {
        smart = {
          title = "󰧑 Smart Search",
        },
        files = {
          title = " Search (Filenames)",
        },
        grep = {
          title = " Search (Contents)",
        },
        buffers = {
          title = " Buffers",
          layout = {
            preset = "select",
            layout = {
              max_width = 50,
            },
          },
        },
        explorer = {
          title = " Explore",
        },
      },
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "i", "n" } },
          },
        },
      },
    },
  })

  -- Keymaps
  vim.keymap.set("n", "<C-p>", Snacks.picker.smart)
  vim.keymap.set("n", "<C-f>", Snacks.picker.files)
  vim.keymap.set("n", ";", Snacks.picker.buffers)
  vim.keymap.set("n", "<C-A-p>", Snacks.picker.grep)
  vim.keymap.set("n", "-", Snacks.explorer.open)

  -- Colors
  vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = vim.g.terminal_color_4 })
  vim.api.nvim_set_hl(0, "SnacksDashboardFile", { fg = vim.g.terminal_color_5 })
  vim.api.nvim_set_hl(0, "SnacksDashboardFile", { fg = vim.g.terminal_color_6 })
  vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = vim.g.terminal_color_2 })
  vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = vim.g.terminal_color_4 })
  vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = vim.g.terminal_color_3 })
  vim.api.nvim_set_hl(0, "SnacksDashboardTitle", { fg = vim.g.terminal_color_5 })
  vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { fg = vim.g.terminal_color_4 })
  vim.api.nvim_set_hl(0, "SnacksPickerTitle", { fg = vim.g.terminal_color_4 })
  vim.api.nvim_set_hl(0, "SnacksTitle", { fg = vim.g.terminal_color_2 })
end
-- }}}
