set nocompatible
set history=500
syntax on
syntax enable
let mapleader = ","
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set showcmd
set showmatch
:set noswapfile
set scrolloff=5
set backspace=indent,eol,start
set ttyfast
set laststatus=2
set encoding=utf-8
set ruler
set autoindent
set smartindent
filetype on
filetype plugin on
set noshowmode
set wrap linebreak
set nolist
set wildmenu
set autoread
set noerrorbells
set novisualbell
set ffs=unix,dos,mac
set incsearch       " incremental search "
set hlsearch        " highlight matched items in search "
set ignorecase      " ignore case while search "
set smartcase
set laststatus=2
set t_Co=256

:command WQ wq
:command Wq wq
:command W w
:command Q q

" colors for matched search items "
highlight Search cterm=NONE ctermbg=220 ctermfg=0

" Press CTRL+L for removing the highlighted colors after search "
nnoremap <silent> <C-l> :nohl<CR>
set number
set relativenumber

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
    :exec '!cat % | xclip -selection clipboard'
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
else
    " adding colors for highlighting current cursor line "
    set cursorline
    highlight CursorLine cterm=NONE ctermbg=234
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
    Plug 'vim-airline/vim-airline',
    Plug 'scrooloose/nerdtree',
    Plug 'scrooloose/nerdcommenter',
    Plug 'Nopik/vim-nerdtree-direnter',
    Plug 'vim-airline/vim-airline-themes',
    Plug 'mhartington/oceanic-next',
    Plug 'MattesGroeger/vim-bookmarks',
    Plug 'kaicataldo/material.vim', { 'branch': 'main' }
call plug#end()

" ============================ Material Theme ============================="
let g:material_terminal_italics = 1
let g:material_theme_style = 'default'
colorscheme material
let g:airline_theme = 'material'

"  ============================ NerdCommenter Plugin ============================ "
" Add spaces after comment delimiters by default "
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments"
let g:NERDCompactSexyComs = 1
" Allow commenting and inverting empty lines (useful when commenting a region) "
let g:NERDCommentEmptyLines = 1
" Align line-wise comment delimiters flush left instead of following code indentation "
let g:NERDDefaultAlign = 'left'
autocmd! VimEnter * call s:fcy_nerdcommenter_map()
function! s:fcy_nerdcommenter_map()
    " use CTRL+/ to toggle comments, <C-_> might not work in mac. Mapped recursively, <leader>c<space> is mapping for NERDCommenterToggle"
    nmap  <C-_>  <leader>c<space>
    vmap  <C-_>  <leader>c<space>
endfunction

" ============================= vim-airline ================================== "
let g:airline_theme='papercolor'
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

