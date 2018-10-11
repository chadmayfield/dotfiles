" ~/.vimrc: personal vim initializations 

" author  : Chad Mayfield (chad@chd.my)
" license : gplv3

if $TERM == "xterm-256color"
    set t_Co=256               " enable 256 colors
endif

" use 256 colors in terminal (and tmux)
if !has("gui_running")
    set t_Co=256
    set term=screen-256color
endif

if &t_Co > 2 || has("gui_running")
    syntax on                  " if term has color,turn on syntax hightlight
    set hlsearch               " hughlighting in last used search pattern
endif

"if &term =~ '256color'         " fix tmux issues
"    set t_ut=
"endif

" fix error; "E45: 'readonly' option is set (add ! to override)"
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

"let g:hybrid_custom_term_colors = 1
"let g:hybrid_reduced_contrast = 1 
colorscheme hybrid             " set colorcheme
set background=dark            " use dark background
"set background=light          " use light background
syntax on                      " turn on syntax highlighting

"set smartindent               " enable smart indent
set autoindent                 " auto indent next line
filetype indent on             " depending on filetype

set tabstop=4                  " size of hard tab
set shiftwidth=4               " size of indent
set expandtab                  " always use spaces instead of tabs

"set backup                    " keep a backup file
set backupdir=~/.vim/backups   " where to put backup files
"set noswapfile                " disable swap file
set viminfo='20,\"50           " r/w .viminfo file, don't store < 50 lines
"set ruler                     " show cursor position all the time
"set nowrap                    " set wrapping to off
set vb                        " turn off the beep within vim
set wildignore=*.swp,*.bak     " ignore files

set nocompatible               " explicitly get out of vi-compatible mode
set history=1000               " store lots of :cmdline history
set undodir=~/.vim/undo        " location to save undo history
set undolevels=1000            " number of undos to save

set backspace=indent,eol,start " allow backspace in insert mode
set number                     " line numbers are good
set showmatch                  " show matching brackets
set showmode                   " how current mode down the bottom
set hlsearch                   " highlight searches by default
set incsearch                  " incremental search, search as you type

set ls=2                       " always show status line
set title                      " show filename in title bar
"set list                      " show tabs, to get them out of files

noremap ; :                    " set ; as and alias

set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

" provide visual feedback for paste toggle see http://bit.ly/2ppWaTl
nnoremap <F2> :set invpaste paste?<CR>  
set pastetoggle=<F2>                " toggle :set paste/:set nopaste on/off
set showmode

cmap w!! w !sudo tee % >/dev/null   " forgot sudo? np, use w!! to invoke in file

" if needed disable .netrwhist file: http://stackoverflow.com/a/9850662
"set netrw_dirhistmax=0

" use netrwhist clone NERDtree behavior without installing plugins
let g:netrw_banner = 0              " remove banner
let g:netrw_liststyle = 3           " list style 3, tree format
let g:netrw_browse_split = 4        " open in previous window
let g:netrw_sort_sequence = '[\/]$,*' " sort dir @ top, followed by files
let g:netrw_altv = 1                " to the right of the project drawer
let g:netrw_winsize = -25            " width of 'directory tree' window
let g:netrw_sort_sequence = '[\/]$,*'         " sort dir @ top, then files
let g:netrw_list_hide='^\.,.\(pyc\|pyo\|o\)$' " hide files
"augroup ProjectDrawer
"    autocmd!
"    autocmd VimEnter * :Vexplore   " launch immediately after entering vim
"augroup END

" toggle Vexplore with ^C-E (http://stackoverflow.com/a/5636941)
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set encoding=utf-8
    set fileencodings=utf-8,latin1
endif

"EOF
