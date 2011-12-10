" ~/.(g)vi(m)rc | vi: set ft=vim: | Curtis Free (http://curtisfree.com)

" Miscellaneous
set nocompatible
set noerrorbells      " no error bells (still bells for many things)
set visualbell        " we'll at least avoid an audible bell
set vb t_vb=          " despite those settings, we'll ensure no bells (ever)
set title             " set window/terminal title
set ruler             " always display location info
set showcmd           " show partial cmds in last line
set cmdheight=1       " give only one command line
set history=50        " remember 50 commands
set virtualedit=block " allow virtual editing in visual block mode
set pastetoggle=<F8>  " toggle paste (see http://bbs.archlinux.org/viewtopic.php?pid=425987#p425987)
set scrolloff=2       " provide a "buffer" of two lines below/above cursor
let mapleader=","     " use comma as the <leader> character
syntax enable         " use syntax highlighting
highlight clear       " clear any special highlighting

" Editing
set backspace=indent,eol,start     " backspace over everything
set listchars=eol:$,trail:_,tab:>- " 'list' mode chars

" File Backup
"" :help backup-table
set nobackup
set writebackup

" Swap
set directory=. " (only) store swap files along with actual files

" Undo
" see http://amix.dk/blog/post/19548
if (version >= 730)
  set undolevels=1000 " remember 1000 undo levels
  set noundofile      " don't persist undo information
  set undoreload=100  " if we _do_ persist (manual set), only remember 100 undo levels
  set undodir=.       " (only) store undo files along with actual files
endif

" Searching
set incsearch  " perform incremental searching
set hlsearch   " highlight search results
set ignorecase " typically (see below) ignore case
set smartcase  " only consider case if an upper case char is used

" Tabs/Indentation
set expandtab     " insert tabs as spaces
set tabstop=4     " use 4 spaces for tabs
set shiftwidth=4  " use 4 spaces when indenting
set autoindent    " automatically indent lines
set nosmartindent " don't use "smart" indenting

" Language
set spelllang=en_us

" Abbreviations
ab _cf Curtis Free (http://curtisfree.com)

" Maps
"" overrides
""" :q often mistyped as q:
map  q: <C-g>
vmap q: <C-g>
"" line numbers
map  <F2> :setlocal number!<CR>
imap <F2> <C-o>:setlocal number!<CR>
vmap <F2> <Esc>:setlocal number!<CR>
"" highlight matches
map  <F3> :setlocal hlsearch!<CR>
imap <F3> <C-o>:setlocal hlsearch!<CR>
vmap <F3> <Esc>:setlocal hlsearch!<CR>
"" cursor col/line
map  <F4> :setlocal cursorcolumn! cursorline!<CR>
imap <F4> <C-o>:setlocal cursorcolumn! cursorline!<CR>
vmap <F4> <Esc>:setlocal cursorcolumn! cursorline!<CR>
"" spell checking
"" see http://cinderwick.ca/files/configs/vimrc
map  <F5> :setlocal spell!<CR>
imap <F5> <C-o>:setlocal spell!<CR>
vmap <F5> <Esc>:setlocal spell!<CR>
"" find/highlight current word
map  <F6> :set hlsearch<CR>:let @/="<C-r><C-w>"<CR>
imap <F6> <C-o>:set hlsearch<CR><C-o>:let @/="<C-r><C-w>"<CR>
vmap <F6> <Esc>:set hlsearch<CR>:let @/="<C-r><C-w>"<CR>
"" show some non-printable characters
map  <F7> :setlocal list!<CR>
imap <F7> <C-o>:setlocal list!<CR>
vmap <F7> <Esc>:setlocal list!<CR>
"" graphical line movement when using arrow keys
""" up
map  <Up> g<Up>
imap <Up> <C-o>g<Up>
vmap <Up> g<Up>
""" down
map  <Down> g<Down>
imap <Down> <C-o>g<Down>
vmap <Down> g<Down>
"" easy page up/down
""" page up
map  <C-k> <C-u>
imap <C-k> <C-u>
vmap <C-k> <C-u>
""" page down
map  <C-j> <C-d>
imap <C-j> <C-d>
vmap <C-j> <C-d>
"" tab movement
""" next
map <C-l> :tabnext<CR>
imap <C-l> <C-o>:tabnext<CR>
vmap <C-l> :tabnext<CR>
""" previous
map <C-h> :tabprevious<CR>
imap <C-h> <C-o>:tabprevious<CR>
vmap <C-h> :tabprevious<CR>
"" alternate tab movement
"map < :tabp<CR>
"map > :tabn<CR>
"" easy tab manipulation
"" see http://dailyvim.blogspot.com/2008/11/tabs.html
map <leader>to :tabnew<CR>
map <leader>tf :tabnew<Space>
map <leader>tc :tabclose<CR>
map <leader>tm :tabmove<Space>
map <leader>tn :tabnext<CR>
map <leader>tp :tabprevious<CR>

" GUI Specifics
if has("gui_running")
  " allow mouse use
  set mouse=a
  " terminal-like pasting
  map  <S-Insert> <MiddleMouse>
  imap <S-Insert> <MiddleMouse>
  vmap <S-Insert> <MiddleMouse>
  " 'select all' (bothersome if accustomed to GNU Screen)
  "map  <C-a> ggVG
  "imap <C-a> <Esc>ggVG
  "vmap <C-a> <Esc>ggVG
  " tab switching (as with other GTK+ apps)
  map  <C-Tab>   :tabn<CR>
  map  <S-C-Tab> :tabp<CR>
  imap <C-Tab>   <C-o>:tabn<CR>
  imap <S-C-Tab> <C-o>:tabp<CR>
  vmap <C-Tab>   <Esc>:tabn<CR>
  vmap <S-C-Tab> <Esc>:tabp<CR>
  " font
  set guifont=Termsyn\ 10,Terminus\ 9,DejaVu\ Sans\ Mono\ 9
  " various options
  set guioptions=acih
  " hide the mouse when typing
  set mousehide
  " highlight current row
  set cursorline
" Console Specifics
else
  " no mouse use
  set mouse=
  " use only 8 colors
  set t_Co=8
endif

" MacVim
"" See http://serverfault.com/questions/70196/how-to-tell-if-im-in-macvim-in-vimrc.
if has("gui_macvim")
  " font for Mac
  set guifont=Menlo\ Regular:h12
  " colorscheme
  "" http://stackoverflow.com/questions/5698284/in-my-vimrc-how-can-i-check-for-the-existence-of-a-color-scheme/5702498
  try
    colorscheme mustang
  catch
    colorscheme slate
  endtry
endif

" Commands/Functions
"" StripTrailingSpaces
"" See http://vim.wikia.com/wiki/Remove_unwanted_spaces.
function! StripTrailingSpaces()
  exec ':%s/\s\+$//e'
endfunction
"" SUw
"" Writes a file even if not running as superuser (via sudo).
"" Odd command name ("SUw") to prevent accidents.
"" Hit "L" at the prompt.
"" See http://writequit.org/blog/?p=195.
command! SUw %!sudo tee >/dev/null %

" Options/Params
"" assume BASH for shell scripts (see sh.vim; "$(...)" won't be flagged as error)
let is_bash=1

" Filetypes
if has("autocmd")
  filetype plugin indent on " automatic per-language indentation
  " filetype detection
  "" see http://beerpla.net/2008/04/02/how-to-add-a-vim-file-extension-to-syntax-highlighting/
  augroup filenames
    autocmd BufRead,BufNewFile *.go setlocal filetype=go
    autocmd BufRead,BufNewFile *.md setlocal filetype=markdown
  augroup end
  " specific filetype overrides
  augroup filetypes
    " reset if ft changes
    autocmd FileType *              setlocal expandtab   tabstop=4 shiftwidth=4
    " filetypes
    autocmd FileType asm            setlocal noexpandtab tabstop=8 shiftwidth=8
    autocmd FileType html,xhtml,xml setlocal             tabstop=2 shiftwidth=2
    autocmd FileType make           setlocal noexpandtab
    autocmd FileType st             setlocal noexpandtab
    autocmd FileType sql,plsql      setlocal             tabstop=2 shiftwidth=2
    autocmd FileType sudoers        setlocal noexpandtab
    autocmd FileType tex,plaintex   setlocal noexpandtab tabstop=2 shiftwidth=2
    autocmd FileType verilog        setlocal noexpandtab
    autocmd FileType vim            setlocal             tabstop=2 shiftwidth=2
  augroup end
endif

" Specific Terminals
"" screen
if &term =~ "screen"
  " terminal title adjustments
  set t_ts=]2;
  set t_fs=
  " needed for mouse
  set ttymouse=xterm2
endif

" Pathogen (https://github.com/tpope/vim-pathogen)
"" See http://stackoverflow.com/questions/5983906/vim-conditionally-use-fugitivestatusline-function-in-vimrc.
silent! call pathogen#infect()

" Local Customizations
"" See http://tech.groups.yahoo.com/group/vim/message/56224.
let local_vimrc=expand("~/.vimrc-local")
if filereadable(local_vimrc)
  execute "source ".local_vimrc
endif

