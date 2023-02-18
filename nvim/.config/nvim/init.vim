" ~/.(g)vi(m)rc AKA ~/.config/nvim/init.vim | vi: set ft=vim: | Curtis Free (https://curtisfree.com)
" Intended to work with both Vim and Neovim, though I generally use the latter.

" Miscellaneous {{{
set nocompatible      " enable nice things!
set noerrorbells      " no error bells (still bells for other reasons)
set visualbell t_vp=  " we'll at least avoid an audible bell
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
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 0
let g:loaded_python3_provider = 0
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
nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
inoremap <C-\> <C-o>:tab split<CR><C-o>:exec("tag ".expand("<cword>"))<CR>
vnoremap <C-\> <Esc>:tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" }}}

" Maps {{{
"" graphical line movement when using arrow keys
""" up
nnoremap <Up> g<Up>
inoremap <Up> <C-o>g<Up>
vnoremap <Up> g<Up>
""" down
nnoremap <Down> g<Down>
inoremap <Down> <C-o>g<Down>
vnoremap <Down> g<Down>
"" easy page up/down
""" page up
noremap <C-k> <C-u>
""" page down
noremap  <C-j> <C-d>
"" buffer movement
""" next
nnoremap <C-l> :bn<CR>
inoremap <C-l> <C-o>:bn<CR>
vnoremap <C-l> :bn<CR>
""" previous
nnoremap <C-h> :bp<CR>
inoremap <C-h> <C-o>:bp<CR>
vnoremap <C-h> :bp<CR>
""" menu
"""" see https://stackoverflow.com/a/16084326
nnoremap ; :ls<CR>:b<Space>
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

"" assume we are going to have plugins... but we need to...
let include_plugins = 1
"" make sure vim-plug itself is installed {{{
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))

  """ NOTE: It makes me uncomfortable to have the editor execute external
  """       commands without the user's explicit knowledge/consent. So we
  """       ask if the user wants to proceed. You can say no! :-)

  if confirm('Do you want to install vim-plug?', "&Yes\n&No", 2) == 1

    """ See https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation.
    """ (modified so that vim-plug can update itself)
    let plug_dir = has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged'
    execute '!mkdir -p '.data_dir.'/autoload '.plug_dir
    execute '!git clone https://github.com/junegunn/vim-plug.git '.plug_dir.'/vim-plug'
    execute '!ln -s '.plug_dir.'/vim-plug/plug.vim '.data_dir.'/autoload/'
    """ adjust runtimepath in case the data_dir didn't yet exist at startup
    execute "set runtimepath^=".data_dir
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC | quit
    unlet plug_dir

  """ no plugins? make this as smooth as possible for the user (no errors)
  else
    echomsg 'Continuing without plugins...'
    let include_plugins = 0
  endif

endif
unlet data_dir
" }}}

if include_plugins
  call plug#begin()
  Plug 'junegunn/vim-plug'

  """ BufTabLine {{{
  Plug 'ap/vim-buftabline'
  """" only show the tab line when it makes sense
  let g:buftabline_show = 1
  """" show when modified
  let g:buftabline_indicators = 1
  """ }}}

  """ NERD Commenter {{{
  Plug 'preservim/nerdcommenter'
  """ }}}

  """ NERD Tree {{{
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
  """ }}}

  """ Fugitive (Git) {{{
  Plug 'tpope/vim-fugitive'
  """ }}}

  """ TBone (tmux integration) {{{
  Plug 'tpope/vim-tbone'
  """ }}}

  """ Base16 Color Themes {{{
  Plug 'chriskempson/base16-vim'
  """ }}}

  """ VimWiki (+ TaskWiki) {{{
  Plug 'vimwiki/vimwiki'
  let g:vimwiki_global_ext = 0
  let wiki = {}
  let wiki.name = 'Notes'
  let wiki.path = '~/Notes'
  let wiki.syntax = 'markdown'
  let wiki.ext = 'md'
  let wiki.diary_rel_path = 'Today/'
  """" (auto index does not work with a custom index file/path)
  "let wiki.diary_index = 'Timeline'
  let wiki.diary_header = 'Timeline'
  let wiki.auto_diary_index = 1
  let g:vimwiki_list = [ wiki ]

  """" (make it easier to increase indent; to the right of <C-d>/decrease)
  inoremap <C-f> <C-t>

  """" + TaskWiki (if Taskwarrior installed)
  if executable('task')
    Plug 'tools-life/taskwiki'
  endif
  """ }}}

  """ FZF (if installed) {{{
  if executable('fzf')

    """" handle symlinks created by executable managers like Homebrew
    """" ('<binary>/../../' should be the install location)
    let fzfdir=fnamemodify(resolve(exepath('fzf')), ':p:h:h')
    let fzfplugin=fzfdir.'/plugin/fzf.vim'

    if filereadable(fzfplugin)
      Plug fzfdir
      Plug 'junegunn/fzf.vim'

      """" go ahead and include maps here
      noremap <C-p> :FZF<CR>

    endif

    unlet fzfdir
    unlet fzfplugin
    """ }}}

  endif

  call plug#end()
endif
unlet include_plugins
"" }}}

" Color Scheme {{{
"" ("silent!" means we won't error if the theme isn't installed)
set termguicolors
let base16colorspace=256
silent! colorscheme base16-tomorrow-night
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
" }}}

" Clipboard {{{
"" copy everywhere (`*` and `+`)
set clipboard=unnamed,unnamedplus
" }}}

" Commands/Functions {{{
"" StripTrailingSpaces
"" See http://vim.wikia.com/wiki/Remove_unwanted_spaces.
function! StripTrailingSpaces() abort
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
