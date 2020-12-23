" Use Vim settings, rather then Vi settings (much better!). "
" This must be first, because it changes other options as a side effect."
set nocompatible

" NOTE: termguicolors are supported by iterm but not by the mac terminal. "

" ================ General ====================== "
let mapleader = ","
set t_Co=256
set history=500                 " Store lots of :cmdline history"
set number                      " Line numbers"
set relativenumber              " Relative line numbers"
set showcmd                     " Show incomplete cmds down the bottom"
set showmatch                   " Show matching brackets when text indicator is over them"
set ruler
set noshowmode
set wrap linebreak
set nolist
set autoread                    " Set to auto read when a file is changed from the outside"
set noerrorbells                " No annoying sound on errors"
set novisualbell                " No annoying sound on errors"
set ffs=unix,dos,mac            " Use Unix as the standard file type "
set encoding=utf-8              " Set utf8 as standard encoding and en_US as the standard language"
set backspace=indent,eol,start  " Configure backspace so it acts as it should act"


"========================== current line or cursorline ==============="
set cursorline
highlight CursorLine cterm=NONE ctermbg=238


"================ syntax highlighting ====================== "
syntax on
syntax enable

" ================ Indentation ================ "
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
set smarttab
filetype on
filetype plugin on
filetype indent on

" ================ Completion ================ "

set wildmode=list:longest
set wildmenu                        "enable ctrl-n and ctrl-p to scroll thru matches"
set wildignore=*.o,*.obj,*~         "stuff to ignore when tab completing"
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ======================== "

set scrolloff=8         "Start scrolling when we're 8 lines away from margins"
set sidescrolloff=15
set sidescroll=1
set ttyfast
set scrolloff=5

" ================ Turn Off Swap Files ============== "
:set noswapfile
set nobackup
set nowb


" ================ Scrolling ======================== "
set incsearch       " incremental search "
set hlsearch        " highlight matched items in search "
set ignorecase      " ignore case while search "
highlight Search cterm=NONE ctermbg=220 ctermfg=0       " colors for matched search items "
nnoremap <silent> <C-l> :nohl<CR>                       " Press CTRL+L for removing the highlighted colors after search "

" ================ Some commands ======================== "
:command WQ wq
:command Wq wq
:command W w
:command Q q

" CTRL+m to go to the corresponding opening/closing bracket "
nnoremap <C-m> %

" in NORMAL mode move to next tab by pressing <Tab> and to previous tab by pressing <Shift-Tab> "
nnoremap <Tab> :tabn<CR>
nnoremap <S-Tab> :tabp <CR>

" ============ VISUAL mode: TAB to indent forward, SHIFT+TAB to indent backwards ============== "
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" ======================  SPLIT related configs ========================== "
" press leaderkey+s for horizontal split "
set splitbelow
set splitright
nnoremap <leader>s :split<CR>

" press leaderkey+v for vertical split "
nnoremap <leader>v :vsplit<CR>

" mappings for moving between the split regions "
noremap <leader>h <C-w>h
noremap <leader>j <C-w>j
noremap <leader>k <C-w>k
noremap <leader>l <C-w>l

" ====================== Return to last edit position when opening files (You want this!) ======================"
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
set viminfo^=% " Remember info about open buffers on close "

" ============================ Execute file right from inside of vim ====================================== "
function RunFile()
    if &filetype ==# 'python'
        :exec '!:w;clear;python3 %'
    elseif &filetype ==# 'cpp'
        :exec '!:w;clear;g++ %;./a.out'
    elseif &filetype ==# 'js'
        :exec '!:w;clear;node %;'
    elseif &filetype ==# 'go'
        :exec '!:w;clear;go run %'
    elseif &filetype ==# 'php'
        :exec '!:w;clear;php %'
    endif
endfunction
:command RUN :call RunFile()

function COPY()
    :exec '!cat % | pbcopy'
endfunction
:command CP :call COPY()

" =========================== color scheme for vim and vimdiff =========================================== "

if &diff
    syntax off
    " adding controls for colors in vimdiff "
    highlight DiffAdd    cterm=NONE ctermfg=15 ctermbg=22
    highlight DiffDelete cterm=NONE ctermfg=15 ctermbg=124
    highlight DiffChange cterm=NONE ctermfg=15 ctermbg=22
    highlight DiffText   cterm=NONE ctermfg=15 ctermbg=88
endif

" ========================== Removes trailing spaces ========================== "
function TrimWhiteSpace()
    let l = line(".")
    let c = col(".")
    :keeppatterns %s/\s\+$//e   " keeppatterns for restoring the search patterns even after TrimWhiteSpaces() "
    call cursor(l, c)           " restore the curser position "
endfunction

function CPPTemplatewithVim()
    0r ~/.vim/templates/base_cplus_plus.cpp
    call cursor(11,31)
endfunction
autocmd BufNewFile *.cpp call CPPTemplatewithVim()
autocmd FileWritePre * call TrimWhiteSpace()
autocmd FileAppendPre * call TrimWhiteSpace()
autocmd FilterWritePre * call TrimWhiteSpace()
autocmd BufWritePre * call TrimWhiteSpace()
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" ========================== Installing plugins via vim-plug.  ============================ "
call plug#begin('~/.vim/plugged')
    Plug 'vim-airline/vim-airline',                             "Lean & mean status/tabline for vim that's light as air."
    Plug 'tpope/vim-fugitive',                                  "Vim plugin for Git"
    Plug 'scrooloose/nerdtree',                                 "NERDTree is a file system explorer for the Vim"
    Plug 'scrooloose/nerdcommenter',                            "Comment functions so powerful—no comment necessary. Works for linux"
    Plug 'Nopik/vim-nerdtree-direnter',                         "Vim NERDTree plugin and set NERDTreeMapOpenInTab to '',"
    Plug 'vim-airline/vim-airline-themes',                      "official theme repository for vim-airline"
    Plug 'MattesGroeger/vim-bookmarks',                         "Bookmarks in vim"
    Plug 'tpope/vim-commentary',                                "Toggle comments using <leader>/ works for mac"
    Plug 'jiangmiao/auto-pairs',                                "Insert or delete brackets, parens, quotes in pair."
call plug#end()

" NOTE: https://github.com/tomasr/molokai seems a promising colorscheme."
" Added this one in ~/.vim/colors/ and its settings somewhere below in here.

" Obviously the last settings for any thing lets say colorsheme, will override the previous ones."

"  ============================ NerdCommenter Plugin ============================ "
let g:NERDSpaceDelims = 1                       " Add spaces after comment delimiters by default "
let g:NERDCompactSexyComs = 1                   " Use compact syntax for prettified multi-line comments"
let g:NERDCommentEmptyLines = 1                 " Allow commenting and inverting empty lines (useful when commenting a region) "
let g:NERDDefaultAlign = 'left'                 " Align line-wise comment delimiters flush left instead of following code indentation "
autocmd! VimEnter * call s:fcy_nerdcommenter_map()
function! s:fcy_nerdcommenter_map()
    " use CTRL+/ to toggle comments, <C-_> might not work in mac. Mapped recursively, <leader>c<space> is mapping for NERDCommenterToggle"
    nmap  <C-_>  <leader>c<space> "Linux"
    vmap  <C-_>  <leader>c<space> "Linux"
endfunction

" ============================= vim-airline ================================== "
let g:airline_theme='minimalist'
let g:airline_solarized_bg='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#show_tab_nr = 1
let airline#extensions#tabline#tabs_label = ''
let airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
call airline#parts#define_raw('linenr', '%l')
call airline#parts#define_accent('linenr', 'bold')
let g:airline_section_z = airline#section#create(['%3p%%  ', 'linenr', ':%c '])

" =================================== NerdTree  =================================== "
" TIP-01: From NerdTree, navigate to file and press t to open that file in new tab"
" TIP-02: To navigate between file tabs, use CTRL+PgUp and CTRL+PgDn "
" for always opening files in NERDTree in new tab, for this mapping to work "
" You will need to install Nopik/vim-nerdtree-direnter plugin as well. "
let NERDTreeMapOpenInTab='<ENTER>'
let NERDTreeKeepTreeInNewTab=1
let NERDTreeIgnore=['\\.pyc', '\\\~$', '\\.swo$', '\\.swp$','\\.git', '\\.hg', '\\.svn', '\\.bzr']
let NERDTreeShowHidden=1

" Hide NERDtree-fileExplorer on opening a file "
" let g:NERDTreeQuitOnOpen = 1 "

" Toggle NerdTree with CTRL+n "
map <C-n> :NERDTreeToggle<CR>

" Close vim if the only window left open is a NERDTree "
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Open NERDTree automatically when vim starts up on opening a directory "
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Expand and collapse folders in NERDTree "
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"=========================  vim-commentary specially for macbook ============================="
nmap  <silent> <leader>/ :Commentary<cr>
vmap  <silent> <leader>/ :Commentary<cr>
nmap  <silent> <C-/> :Commentary<cr>
autocmd FileType php setlocal commentstring=#\ %s "Added support for php as well"

" ================================== tomasr/molokai settings =========================== "
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1

