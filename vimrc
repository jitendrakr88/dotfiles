set nocompatible

" enable syntax
syntax on
syntax enable

" for converting tabs to space, and for handling other tab related issues
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" show command
set showcmd

" matching braces
set showmatch

" enable mouse in vim { mostly not required }
"set mouse=a


set scrolloff=5
set backspace=indent,eol,start
set ttyfast                         " fast scroll

" status line
set laststatus=2
set statusline=%F%m%r%h%w\ [TYPE=%Y]\ [CURSOR=%l,%v][%p%%]
set encoding=utf-8

" show line number
set number
nnoremap <F2> :set nonumber! noai!<CR>

" turnoff line numbers
"set nonumber

set ruler " show column number in status bar

" indentation
set autoindent
filetype on
"filetype plugin indent on

set wildmenu

" color scheme for vim and vimdiff
if &diff
    syntax off
    " adding controls for colors in vimdiff
    highlight DiffAdd    cterm=NONE ctermfg=15 ctermbg=22
    highlight DiffDelete cterm=NONE ctermfg=15 ctermbg=124
    highlight DiffChange cterm=NONE ctermfg=15 ctermbg=22
    highlight DiffText   cterm=NONE ctermfg=15 ctermbg=88
else
    colorscheme twilight256
    " adding colors for highlighting current cursor line
    set cursorline
    highlight CursorLine cterm=NONE ctermbg=234
endif


" search in vim
set incsearch       " incremental search
set hlsearch        " highlight matched items in search
set ignorecase      " ignore case while search

" colors for matched search items
highlight Search cterm=NONE ctermbg=220 ctermfg=0

" Press CTRL+L for removing the highlighted colors after search
nnoremap <silent> <C-l> :nohl<CR><C-l>
