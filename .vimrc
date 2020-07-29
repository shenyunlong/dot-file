" My vim configuration. --YLS

set autoindent
set smartindent
set nu
set ts=4 sts=4 expandtab sw=4 " tabstop, softtabstop, shiftwidth: indent
set sr " shiftround
set ic      " ignorecase, and you can use \C in pattern to force match case

" the # of spcae of indent in cpp is 2 ps: c is 4
autocmd FileType cpp set sw=2 ts=2 sts=2

" for commentary plugin
filetype plugin on

" activate mouse
set mouse=a

" set hidden for edit multi-file without write immediately
set hid

set tags=./tags,tags;
set cursorline
set encoding=UTF-8

" for using H to open help document in spilt window
cnoreabbrev H vert h

" a helper for next map
" expand the directory of the current file anywhere at the command line by pressing %%
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>

" the shotcuts to open a new window/tab to show the current dictionary
let mapleader = ','
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" disable arrowkey in vim
" the arrowkey should be abandoned in vim
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" quick copy all the file
nnoremap <leader>c :,% y+<CR>
" quick copy the word in cursor to paste globally.
nnoremap <leader>w "+yiw

" quick save file
nnoremap <leader>s :<C-u>w<CR>
" quick quit from vim
nnoremap <leader>q :<C-u>q<CR>

" quick compile and run this cpp file
nnoremap <leader>m :!clang++ -std=c++17 -Wall -Wextra -o tmpcpp % && ./tmpcpp && rm ./tmpcpp<CR>

" highlight all its matches of seaching command such as / and %.
set hls

" set the incsearch
set is

" Stop the highlighting for the 'hlsearch' option temporarily.
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR>

" the options for insert completions.
set cot = "menuone, longest"

" the settings for theme tender
if (has("termguicolors"))
    set termguicolors
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-abolish'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yuttie/comfortable-motion.vim'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " in order to make . command work with vim-surround command
Plug 'majutsushi/tagbar'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user' " dependency of textobj-entire
Plug 'vim/killersheep' " vim game for showing off vim 8.2 features

" Initialize plugin system
call plug#end()

" theme settings
set background=dark
colorscheme gruvbox

" ale settings
" ale linter settings
let g:ale_linters = {
\   'c': ['clangd'],
\   'cpp': ['clangd'],
\   'python': ['pyls'],
\   'vim': ['vimls'],
\   'sh': ['shellcheck'],
\   'sql': ['sqlint'],
\   'go': ['golangserver'],
\   'cmake': ['cmakelint'],
\   'json': ['jsonlint'],
\}

" PS: bash-language-server is not work, and shfmt sometime must be syntax
" correct at first
" So far, i donot figure out how to specify the standard of c/cpp
" using ale_c/cpp_clangd_options

let g:ale_linters_explicit = 1

" error navigatation
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" go to definition
nmap <silent> <C-h> <Plug>(ale_go_to_definition)

" use built-in completiono in ale which using lsp
let g:ale_completion_enabled = 1

" unfortunately most lsp cannot support hover, of course include clangd
let g:ale_hover_to_preview = 1

let g:ale_sign_column_always = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_enter = 1
let g:ale_set_signs = 0
let g:ale_auto_refresh_delay = 1

" ale fixer settings, add when need
let g:ale_fixers = {
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\   'cmake': ['cmakeformat'],
\   'python': ['black'],
\   'sql': ['pgformatter'],
\   'go': ['gofmt'],
\   'json': ['prettier'],
\   'sh': ['shfmt'],
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

" sorry i have to say gofmt is the least-useful formatter

let g:ale_fix_on_save = 0

" cland options
" NOTE: it does not work if you use clangd.
let g:ale_cpp_clangd_options = ''

" clangformat options
let g:ale_c_clangformat_options = '-style="{BasedOnStyle: Google, DerivePointerAlignment: false, PointerAlignment: Right, ColumnLimit: 120}"'
let g:ale_cpp_clangformat_options = '-style="{BasedOnStyle: Google, DerivePointerAlignment: false, PointerAlignment: Right, ColumnLimit: 120}"'

noremap <leader>F :<C-u>ALEFix<CR>

" airline settings
" vim built-in statusline settings
set noshowmode
set cmdheight=1
let g:airline_theme = 'gruvbox'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
let g:airline#extensions#branch#enabled = 1

" comfortable-motion settings
let g:comfortable_motion_no_default_key_mappings = 1
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(10)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-10)<CR>

" gitgutter settings
set updatetime=100

" indentline settings
" just use indetlint on demand
let g:indentLine_enabled = 0

" nerdtree settings
" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" donot display hidden file in nerdtree
let NERDTreeShowHidden = 0

" open/close NERDTree with <Ctrl-n>
nmap <C-n> :NERDTreeToggle<CR>

" Making it prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 25

" autopair settings
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = ',b'

" rainbow settings
let g:rainbow_active = 1 " 0 if you want to enable it later via :RainbowToggle

" tagbar settings
nmap <C-b> :TagbarToggle<CR>
