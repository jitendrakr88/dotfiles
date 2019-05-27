set nocompatible
set history=500
" enable syntax
syntax on
syntax enable
let mapleader = ","

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
set ttyfast " fast scroll

" status line
set laststatus=2
"set statusline=%F%m%r%h%w\ [TYPE=%Y]\ [CURSOR=%l,%v][%p%%]
set encoding=utf-8

set ruler " show column number in status bar

" indentation
set autoindent
set smartindent
filetype on
filetype plugin on

set noshowmode
set wrap linebreak
set nolist
set wildmenu
set autoread " auto read if file is changed from outside
"set hidden " hide buffers
set noerrorbells
set novisualbell
" Use Unix as the standard file type
set ffs=unix,dos,mac

" search in vim
set incsearch       " incremental search
set hlsearch        " highlight matched items in search
set ignorecase      " ignore case while search
set smartcase

" colors for matched search items
highlight Search cterm=NONE ctermbg=220 ctermfg=0

" Press CTRL+L for removing the highlighted colors after search
nnoremap <silent> <C-l> :nohl<CR>

set number " show line number
set relativenumber " enable relative numbers, :+n to go to n lines down, :-n to go to n lines up
"set nonumber " turn off line numbers
"set nornu
function ToggleCopyPaste()
    :set nonumber! noai! rnu! nosi! nopaste!
endfunction

nnoremap <F2> :call ToggleCopyPaste() <CR>

" CTRL+m to go to the corresponding opening/closing bracket
nnoremap <C-m> %

" Jump cursor to begining of file in NORMAL MODE
nnoremap <C-Home> gg
nnoremap <C-End> G

" *********************************************************************
" Done to fix CTRL+Arrow keys issue in screen
" Some mapping in related to this is present in bashrc as well (do not forgot to include that)
map <ESC>[5D <C-Left>
map <ESC>[5C <C-Right>
map! <ESC>[5D <C-left>
map! <ESC>[5C <C-Right>
" *********************************************************************

" TIP- pressing w moves the cursur one word ahead and pressing b moves the
" cursur one word back, This is the reason I didn't map quick save to q

" in NORMAL mode move to next tab by pressing <Tab> and to previous tab by pressing <Shift-Tab>
nnoremap <Tab> :tabn<CR>
nnoremap <S-Tab> :tabp <CR>

" in VISUAL mode, after selecting a block of text, press TAB to indent forward
" and SHIFT+TAB to indent backwards
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" fast-save by pressing s in normal mode and keep the file opened
vnoremap s :w! <CR>
nnoremap s :w! <CR>

" do not insert newline on selcting items from suggestion menu. Ex. while autocomplete during editing files
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
" mapped recursively the default behaviour of Enter key when not selecting from options
imap <expr> <CR> pumvisible() ? "\<C-y>" : "<Plug>delimitMateCR"
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"


" **************  SPLIT related configs ******************************
" press leaderkey+s for horizontal split
set splitbelow
set splitright
nnoremap <leader>s :split<CR>
" press leaderkey+v for vertical split
nnoremap <leader>v :vsplit<CR>
" mappings for moving between the split regions
noremap <leader>h <C-w>h
noremap <leader>j <C-w>j
noremap <leader>k <C-w>k
noremap <leader>l <C-w>l
" *******************************************************************

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

" ********************************************************************
" Removes trailing spaces
function TrimWhiteSpace()
    let l = line(".")
    let c = col(".")
    :keeppatterns %s/\s\+$//e   " keeppatterns for restroing the search patterns even after TrimWhiteSpaces()
    call cursor(l, c)           " restore the curser position
endfunction

autocmd FileWritePre * call TrimWhiteSpace()
autocmd FileAppendPre * call TrimWhiteSpace()
autocmd FilterWritePre * call TrimWhiteSpace()
autocmd BufWritePre * call TrimWhiteSpace()

" *********************************************************************
" Installing plugins via vim-plug
" List here all the plugins to be installed
call plug#begin('~/.vim/plugged')
"    Plug 'itchyny/lightline.vim',
    Plug 'vim-airline/vim-airline',
    Plug 'tpope/vim-fugitive',
    Plug 'airblade/vim-gitgutter',
    Plug 'scrooloose/nerdtree',
    Plug 'scrooloose/nerdcommenter',
    Plug 'Nopik/vim-nerdtree-direnter',
    Plug 'vim-airline/vim-airline-themes',
""    Plug 'valloric/youcompleteme',
    Plug 'Raimondi/delimitMate',
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc',
    Plug 'mxw/vim-jsx',
    Plug 'pangloss/vim-javascript'
call plug#end()
" Installing plugins ends.

" **********************************************************************
" Settings for vim-jsx and vim-javascript plugins
let g:jsx_ext_required = 0
let g:jsx_pragma_required = 1
let g:javascript_plugin_jsdoc = 1
" **********************************************************************
" Settings for delimitMate plugin
let delimitMate_expand_cr=1
let g:delimitMate_expand_space = 1
" **********************************************************************
" Settings for deoplete plugin
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
set shortmess+=c
set cmdheight=2
highlight Pmenu ctermfg=255 ctermbg=236
highlight PmenuSel ctermfg=236 ctermbg=255

" **********************************************************************
" Settings for NerdCommenter Plugin
autocmd! VimEnter * call s:fcy_nerdcommenter_map()
function! s:fcy_nerdcommenter_map()
    " use CTRL+/ to toggle comments, <C-_> might not work in mac.
    " able to comment only in NORMAL and VISUAL mode only
    " mapped recursively, <leader>c<space> is mapping for NERDCommenterToggle
    nmap  <C-_>  <leader>c<space>
    vmap  <C-_>  <leader>c<space>
    " nnoremap <leader>cc <plug>NERDCommenterToggle
    " vnoremap <leader>cc <plug>NERDCommenterToggle gv
endfunction
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" **********************************************************************
" Settings for vim-airline plugin
let g:airline_theme='papercolor'
let g:airline_solarized_bg='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#show_tab_nr = 1
let airline#extensions#tabline#tabs_label = ''
let airline#extensions#tabline#show_splits = 0
"let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
call airline#parts#define_raw('linenr', '%l')
call airline#parts#define_accent('linenr', 'bold')
let g:airline_section_z = airline#section#create(['%3p%%  ', 'linenr', ':%c '])

" **********************************************************************
"  Settings for NerdTree
" TIP-01: From NerdTree, navigate to file and press t to open that file in new tab"
" TIP-02: To navigate between file tabs, use CTRL+PgUp and CTRL+PgDn

" for always opening files in NERDTree in new tab, for this mapping to work,
" You will need to install Nopik/vim-nerdtree-direnter plugin as well.
let NERDTreeMapOpenInTab='<ENTER>'

let NERDTreeKeepTreeInNewTab=1
let NERDTreeIgnore=['\\.pyc', '\\\~$', '\\.swo$', '\\.swp$','\\.git', '\\.hg', '\\.svn', '\\.bzr']
let NERDTreeShowHidden=1

"hide NERDtree-fileExplorer on opening a file
" let g:NERDTreeQuitOnOpen = 1 "

" Toggle NerdTree with CTRL+n
map <C-n> :NERDTreeToggle<CR>

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" expand and collapse folders in NERDTree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" **********************************************************************
" Settings for lightline plugin for status line
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename': 'LightlineFilename'
      \ },
      \ }
function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction
" ************************************************************************
