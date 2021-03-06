" ~/.(g)vi(m)rc | vi: set ft=vim: | Curtis Free (https://curtisfree.com)

" Miscellaneous {{{
set nocompatible
set noerrorbells      " no error bells (still bells for many things)
set visualbell        " we'll at least avoid an audible bell
set vb t_vb=          " despite those settings, we'll ensure no bells (ever)
set title             " set window/terminal title
set ruler             " always display location info
set showcmd           " show partial cmds in last line
set cmdheight=1       " give only one command line
set hidden            " allow modified buffers in the background
set history=50        " remember 50 commands
set virtualedit=block " allow virtual editing in visual block mode
set pastetoggle=<F8>  " toggle paste (see http://bbs.archlinux.org/viewtopic.php?pid=425987#p425987)
set scrolloff=2       " provide a "buffer" of two lines below/above cursor
set splitright        " open new vsplits to the right (http://stackoverflow.com/a/7912621)
set splitbelow        " open new splits below (http://stackoverflow.com/a/7912621)
set tabpagemax=1000   " allow up to 1k tabs (http://www.linux.com/archive/feed/59533)
set foldmethod=marker " fold on `{{{` `}}}`
let mapleader=","     " use comma as the <leader> character
syntax enable         " use syntax highlighting
highlight clear       " clear any special highlighting
" }}}

" Neovim Providers {{{
"" disable providers I don't use
let g:loaded_node_provider = 0
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
" }}}

" Editing {{{
set backspace=indent,eol,start " backspace over everything
set list                       " show tabs and trailing spaces (in conjuction with `listchars`)
set listchars=trail:·,tab:»·   " 'list' mode chars (http://stackoverflow.com/q/18321538)
" }}}

" File Backup {{{
"" :help backup-table
set nobackup
set writebackup
" }}}

" Swap {{{
set directory=.,/tmp " prefer storing swap files along with actual files
" }}}

" Undo {{{
" see http://amix.dk/blog/post/19548
if (version >= 703)
  set undolevels=1000 " remember 1000 undo levels
  set noundofile      " don't persist undo information
  set undoreload=100  " if we _do_ persist (manual set), only remember 100 undo levels
  set undodir=.       " (only) store undo files along with actual files
endif
" }}}

" Searching {{{
set incsearch   " perform incremental searching
set hlsearch    " highlight search results
set ignorecase  " typically (see below) ignore case
set nosmartcase " never consider case (messes me up)
" }}}

" Tabs/Indentation {{{
set expandtab     " insert tabs as spaces
set tabstop=4     " use 4 spaces for tabs
set softtabstop=4 " act as though tab-spaces are tabs
set shiftwidth=4  " use 4 spaces when indenting
set autoindent    " automatically indent lines
set nosmartindent " don't use "smart" indenting
" }}}

" Language {{{
set spelllang=en_us
" }}}

" Abbreviations {{{
ab _cf Curtis Free (https://curtisfree.com)
" }}}

" Tags {{{
"" See http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks.
set tags=./tags;${HOME}
nmap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
imap <C-\> <C-o>:tab split<CR><C-o>:exec("tag ".expand("<cword>"))<CR>
vmap <C-\> <Esc>:tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" }}}

" Maps {{{
"" overrides
""" :q often mistyped as q:
map  q: <C-g>
vmap q: <C-g>
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
"" buffer movement
""" next
map <C-l> :bn<CR>
imap <C-l> <C-o>:bn<CR>
vmap <C-l> :bn<CR>
""" previous
map <C-h> :bp<CR>
imap <C-h> <C-o>:bp<CR>
vmap <C-h> :bp<CR>
""" menu
"""" see https://stackoverflow.com/a/16084326
map ; :ls<CR>:b<Space>
" }}}

" Interface {{{
set mouse=a  " allow mouse use
set wildmenu " display menu that cycles through command-lne completions
"" Status Line
""" See https://curtisfree.com/blog/2012/04/22/adding_total_line_count_to_vim_statusline.
set laststatus=2                                    " always show the status bar
set statusline=%<%f\ %h%m%r%=%-14.(%l/%L,%c%V%)\ %P " include total line count
" }}}

" Line Numbering {{{
if (version >= 704)
  set number relativenumber
endif
" }}}

" Plugins {{{
"" (via vim-plug; https://github.com/junegunn/vim-plug)
"" See http://stackoverflow.com/questions/5983906/vim-conditionally-use-fugitivestatusline-function-in-vimrc.
silent! call plug#begin()

""" BufTabLine
silent! Plug 'ap/vim-buftabline'
"""" only show the tab line when it makes sense
let g:buftabline_show = 1
"""" show when modified
let g:buftabline_indicators = 1

""" NERD Commenter
silent! Plug 'scrooloose/nerdcommenter'

""" NERD Tree
silent! Plug 'scrooloose/nerdtree'

""" Fugitive (Git)
silent! Plug 'tpope/vim-fugitive'

""" RSI (Readline-Style Insertions)
silent! Plug 'tpope/vim-rsi'

""" TBone (tmux integration)
silent! Plug 'tpope/vim-tbone'

""" Mustang2 (color scheme)
silent! Plug 'vim-scripts/Mustang2'

""" VimWiki
silent! Plug 'vimwiki/vimwiki'
let g:vimwiki_global_ext = 0
let wiki = {}
let wiki.name = 'Notes'
let wiki.path = '~/Notes'
let wiki.syntax = 'markdown'
let wiki.ext = 'md'
let wiki.diary_rel_path = 'Today/'
" (auto index does not work with a custom index file/path)
"let wiki.diary_index = 'Timeline'
let wiki.diary_header = 'Timeline'
let wiki.auto_diary_index = 1
let g:vimwiki_list = [ wiki ]

"""" (make it easier to increase indent; to the right of <C-d>/decrease)
imap <C-f> <C-t>

"""" + TaskWiki (if Taskwarrior installed)
if executable('task')
  silent! Plug 'tools-life/taskwiki'
endif

""" include fzf only if we have it
if executable('fzf')

  """" handle symlinks created by executable managers like Homebrew
  """" ('<binary>/../../' should be the install location)
  let fzfdir=fnamemodify(resolve(exepath('fzf')), ':p:h:h')
  let fzfplugin=fzfdir.'/plugin/fzf.vim'

  if filereadable(fzfplugin)
    silent! Plug fzfdir
    silent! Plug 'junegunn/fzf.vim'

    """" go ahead and include maps here
    map <C-f> :FZF<CR>

  endif

  unlet fzfdir
  unlet fzfplugin

endif

silent! call plug#end()
"" }}}

" Color Scheme {{{
"" In opposite order of preference so that the last successful call wins.
silent! colorscheme Mustang
" }}}

" GUI Specifics {{{
if has("gui_running")
  " terminal-like pasting
  map  <S-Insert> <MiddleMouse>
  imap <S-Insert> <MiddleMouse>
  vmap <S-Insert> <MiddleMouse>
  " tab switching (as with other GTK+ apps)
  map  <C-Tab>   :tabn<CR>
  map  <S-C-Tab> :tabp<CR>
  imap <C-Tab>   <C-o>:tabn<CR>
  imap <S-C-Tab> <C-o>:tabp<CR>
  vmap <C-Tab>   <Esc>:tabn<CR>
  vmap <S-C-Tab> <Esc>:tabp<CR>
  " font
  silent! set guifont=Monospace
  " GUI config (note: don't automatically put visual selection in clipboard)
  set guioptions=ceih
  " hide the mouse when typing
  set mousehide
  " highlight current row (but no cursorcolumn)
  set cursorline
" Console Specifics
else
  " use 256 colors
  set t_Co=256
endif
" }}}

" Terminals {{{
"" screen
if &term =~ "screen"
  " terminal title adjustments
  set t_ts=]2;
  set t_fs=
  " needed for mouse
  set ttymouse=xterm2
" xterm (or iTerm2, etc.)
"" See http://stackoverflow.com/questions/2105880/how-can-i-get-the-file-i-have-open-in-vim-to-display-in-my-iterm-tab.
elseif &term =~ "xterm"
  " terminal title adjustments
  set t_ts=]1;
  set t_fs=
endif
" {{{

" Clipboard {{{
"" copy everywhere (`*` and `+`)
set clipboard=unnamed,unnamedplus
" }}}

" Commands/Functions {{{
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
"" CleanDOS
"" Fix DOS line endings.
command! CleanDOS %s//\r/g
" }}}

" Options/Params {{{
"" assume BASH for shell scripts (see sh.vim; "$(...)" won't be flagged as error)
let is_bash=1
" }}}

" Filetypes {{{
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
    autocmd FileType *              setlocal expandtab   tabstop=4 softtabstop=4 shiftwidth=4
    " filetypes
    autocmd FileType asm            setlocal noexpandtab tabstop=8 softtabstop=4 shiftwidth=8
    autocmd FileType gitcommit      setlocal                                                                  spell
    autocmd FileType html,xhtml,xml setlocal             tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType make           setlocal noexpandtab
    autocmd FileType markdown       setlocal                                    colorcolumn=101 textwidth=100
    autocmd FileType st             setlocal noexpandtab
    autocmd FileType sql,plsql      setlocal             tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType sudoers        setlocal noexpandtab
    autocmd FileType tex,plaintex   setlocal noexpandtab tabstop=2 softtabstop=2 shiftwidth=2 colorcolumn=101 textwidth=100 spell inde=
    autocmd FileType verilog        setlocal noexpandtab
    autocmd FileType vim            setlocal             tabstop=2 softtabstop=2 shiftwidth=2
  augroup end
  " custom types
  augroup custom
    autocmd BufRead,BufNewFile *.notes setlocal filetype=markdown tabstop=2 softtabstop=2 shiftwidth=2 colorcolumn=101 textwidth=100
  augroup end
endif
" }}}

" Local Customizations {{{
"" See http://tech.groups.yahoo.com/group/vim/message/56224.
let local_vimrc=expand("~/.vimrc.local")
if filereadable(local_vimrc)
  execute "source ".local_vimrc
endif
unlet local_vimrc
let local_dotvim=expand("~/.vim.local")
if isdirectory(local_dotvim)
  execute "set runtimepath^=".local_dotvim
endif
unlet local_dotvim
" }}}
