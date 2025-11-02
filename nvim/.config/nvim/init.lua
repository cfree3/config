-- ~/.config/nvim/init.lua | Curtis Free (https://curtisfree.com)
-- General configuration for Neovim. (Plugins and filetype settings in separate Lua scripts!)

-- Startup {{{
-- ▶︎ Clear anything that was highlighted (due to search) previously
vim.cmd("highlight clear")
-- }}}

-- Neovim Providers {{{
-- ▶︎ Disable providers I don't use
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
-- }}}

-- Buffers {{{
vim.opt.hidden = true
-- }}}

-- Command History {{{
vim.opt.history = 50
-- }}}

-- Interface & Editing {{{

vim.opt.backspace = "indent,eol,start"
vim.opt.cmdheight = 1
vim.opt.cursorline = true
vim.opt.errorbells = false
vim.opt.foldmethod = "marker"
vim.opt.list = true
vim.opt.listchars = "trail:·,tab:»·,precedes:⇐,extends:⇒"
vim.opt.mouse = "a"
vim.opt.ruler = true
vim.opt.scrolloff = 2
vim.opt.showcmd = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.title = true
vim.opt.virtualedit = "block"
vim.opt.visualbell = true
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"
vim.opt.wrap = false

-- ▶︎ Window title
--   ▶︎ Mostly the default, but lose " - Nvim" at the end
vim.opt.titlestring = [[%t%( (%{expand("%:~:h")})%)%a]]

-- ▶︎ Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- ▶︎ Status line
--   ▶︎ See https://curtisfree.com/blog/2012/04/22/adding_total_line_count_to_vim_statusline
--   ▶︎ Always show the status bar
vim.opt.laststatus = 2
vim.opt.winbar = [[%<%#Directory#[%n] %#ModeMsg#%t%#NonText#%( (%{expand("%:~:h")})%)%=%m%r%y]]
vim.opt.statusline = [[%=%-14.(%l/%L,%c%V%) %P]]
vim.opt.termguicolors = true

-- }}}

-- Undo, Swap, & Backup {{{

-- ▶︎ Use default location for swap files (vs. alongside files themselves)

-- ▶︎ Keep a healthy amount of undo
vim.opt.undolevels = 1000

-- ▶︎ See `:help backup-table`
vim.opt.backup = false
vim.opt.writebackup = true

-- }}}

-- Searching {{{
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = false
-- }}}

-- Tabs/Indentation {{{
-- ▶︎ These may be changed per filetype (after/ftplugin/*.lua)
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = false
-- }}}

-- Language {{{
vim.opt.spelllang = "en_us"
-- }}}

-- Abbreviations {{{
vim.cmd("ab _cf Curtis Free (https://curtisfree.com)")
-- }}}

-- Maps {{{

-- ▶︎ Set leader for certain maps (usually from plugins)
vim.g.mapleader = ","

-- ▶︎ Graphical line movement when using arrow keys
--   ▶︎ Up
vim.keymap.set("n", "<Up>", "g<Up>")
vim.keymap.set("i", "<Up>", "<C-o>g<Up>")
vim.keymap.set("v", "<Up>", "g<Up>")
--   ▶︎ Down
vim.keymap.set("n", "<Down>", "g<Down>")
vim.keymap.set("i", "<Down>", "<C-o>g<Down>")
vim.keymap.set("v", "<Down>", "g<Down>")

-- ▶︎ Easy page up/down
--   ▶︎ Up
vim.keymap.set("", "<C-k>", "<C-u>")
--   ▶︎ Down
vim.keymap.set("", "<C-j>", "<C-d>")

-- ▶︎ Buffer movement
--   ▶︎ Next
vim.keymap.set("n", "<C-l>", ":bn<CR>")
vim.keymap.set("i", "<C-l>", "<C-o>:bn<CR>")
vim.keymap.set("v", "<C-l>", ":bn<CR>")
--   ▶︎ Previous
vim.keymap.set("n", "<C-h>", ":bp<CR>")
vim.keymap.set("i", "<C-h>", "<C-o>:bp<CR>")
vim.keymap.set("v", "<C-h>", ":bp<CR>")

-- ▶︎ Terminal
--   ▶︎ Easy escape (https://www.reddit.com/r/neovim/comments/yg2d9v/comment/iu7zeip/)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- }}}

-- Netrw {{{
-- ▶︎ See https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
vim.g.netrw_winsize = 20
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_list_hide = "^..*.sw.$"
vim.keymap.set("n", "-", ':Lexplore<CR>:setlocal winbar=%{expand("%:~:h")}<CR>')
-- }}}}

-- Plugins {{{
require("plugins.lazy")
-- }}}

-- Clipboard {{{
-- ▶︎ Copy everywhere (`*` and `+`)
vim.opt.clipboard = "unnamed,unnamedplus"
-- }}}

-- Commands/Functions {{{
-- ▶︎ StripTrailing (http://vim.wikia.com/wiki/Remove_unwanted_spaces)
vim.api.nvim_create_user_command("StripTrailing", function()
  vim.cmd(":%s/\\s\\+$//e")
end, {})
-- }}}
