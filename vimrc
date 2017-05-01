" ~/.vimrc: personal vim initializations 
"
" author  : Chad Mayfield (chad@chd.my)
" license : gplv3

if $TERM == "xterm-256color"
    set t_Co=256               " enable 256 colors
endif

if &t_Co > 2 || has("gui_running")
    syntax on                  " if term has color,turn on syntax hightlight
    set hlsearch               " hughlighting in last used search pattern
endif

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
"set vb                        " turn off the beep within vim
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

set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

" provide visual feedback for paste toggle see http://bit.ly/2ppWaTl
nnoremap <F2> :set invpaste paste?<CR>  
set pastetoggle=<F2>           " toggle ':set paste/:set nopaste' on/off
set showmode

" statusline ex 1 from; http://www.plainlystated.com/2009/05/vim-statusline/
" [10] app/models/user.rb          [ruby][Rails-model-arb]    (1/276) Top
"------------------------------
"set statusline=
"set statusline+=%<                 " cut at start
"set statusline+=%2*[%n%H%M%R%W]%*  " buffer number, and flags
"set statusline+=%-40f              " relative path
"set statusline+=%=                 " seperate between right/left-aligned
"set statusline+=%1*%y%*%*          " file type
"set statusline+=%10((%l/%L)%)      " line and column
"set statusline+=%P                 " percentage of file

" .netrwhist: http://www.drchip.org/astronaut/vim/index.html#NETRW
" and to disable it: http://stackoverflow.com/a/9850662
"set netrw_dirhistmax=0

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set encoding=utf-8
    set fileencodings=utf-8,latin1
endif

"EOF
