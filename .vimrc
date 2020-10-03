" My vim configuration. --YLS

" ===
" === System
" ===


set autoindent
set smartindent
set nu
set rnu
set ts=4 sts=4 expandtab sw=4   " tabstop, softtabstop, shiftwidth: indent
set sr  " shiftround
set ic  " ignorecase, and you can use \C in pattern to force match case

" the # of spcae of indent in cpp is 2 ps: c is 4
autocmd FileType cpp set sw=2 ts=2 sts=2

" for commentary plugin
filetype plugin on

" activate mouse
set mouse=a

" set hidden for edit multi-file without write immediately
set hid

" vim built-in statusline settings
set noshowmode
set cmdheight=1

set tags=./tags,tags;
set cursorline
set encoding=UTF-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

" for using H to open help document in spilt window
cnoreabbrev H vert h

" a helper for next map
" expand the directory of the current file anywhere at the command line by pressing %%
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>

" the shotcuts to open a new window/tab to show the current dictionary
let mapleader = ','
" this key is conflict with my Leaderf mapping key.
" map <leader>ew :e %%
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
nnoremap <leader>y :,% y+<CR>
" quick copy the word in cursor to paste globally.
nnoremap <leader>w "+yiw

" quick save file
nnoremap <leader>s :<C-u>w<CR>
" quick quit from vim
nnoremap <leader>q :<C-u>q<CR>

" quick compile and run this cpp file
" TODO: use another shortcut key.
nnoremap <leader>m :!clang++ -std=c++17 -Wall -Wextra -o tmpcpp % && ./tmpcpp && rm ./tmpcpp<CR>

" highlight all its matches of seaching command such as / and %.
set hls

" set the incsearch
set is

" Stop the highlighting for the 'hlsearch' option temporarily.
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR>

" the options for insert completions.
set cot = "menuone, longest"

" TODO: open images with iterm imgcat


" ===
" === Color settings
" ===

if (has("termguicolors"))
    set termguicolors
endif

" https://tomlankhorst.nl/iterm-tmux-vim-true-color/
" it works for using vim inside tmux.
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"



" ===
" === vim-plug
" ===

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-abolish'
" Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
Plug 'lervag/vimtex' " vim filetype plugin for laTeX files.
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'mhinz/vim-startify'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim'
Plug 'ashisha/image.vim', {'for': 'image'}
Plug 'easymotion/vim-easymotion'
Plug 'previm/previm', {'for': 'markdown'}

" Initialize plugin system
call plug#end()

" ===
" === Theme
" ===

set background=dark
colorscheme gruvbox


" ===
" === Asynchronous Lint Engine
" ===

" ale linter settings
" let g:ale_linters = {
" \   'c': ['clangd'],
" \   'cpp': ['clangd'],
" \   'python': ['pyls', 'pylint'],
" \   'vim': ['vimls'],
" \   'sh': ['shellcheck'],
" \   'sql': ['sqlint'],
" \   'go': ['golangserver'],
" \   'cmake': ['cmakelint'],
" \   'json': ['jsonlint'],
" \}

" " PS: bash-language-server is not work, and shfmt sometime must be syntax
" " correct at first
" " So far, i donot figure out how to specify the standard of c/cpp
" " using ale_c/cpp_clangd_options
" let g:ale_linters_explicit = 1

" " error navigatation
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)

" " go to definition
" nmap <silent> <C-h> <Plug>(ale_go_to_definition)

" " alefix, format tool
" noremap <leader>F :<C-u>ALEFix<CR>

" " use built-in completiono in ale which using lsp
" let g:ale_completion_enabled = 1
" let g:ale_completion_autoimport = 1

" " sadly. unfortunately most lsp cannot support hover, of course include clangd
" let g:ale_hover_to_preview = 1

" let g:ale_sign_column_always = 1
" let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_on_text_changed = 1
" let g:ale_lint_on_enter = 1
" let g:ale_set_signs = 0
" let g:ale_auto_refresh_delay = 1

" " ale fixer settings, add when need
" let g:ale_fixers = {
" \   'c': ['clang-format'],
" \   'cpp': ['clang-format'],
" \   'cmake': ['cmakeformat'],
" \   'python': ['black', 'autopep8', 'isort'],
" \   'sql': ['pgformatter'],
" \   'go': ['gofmt'],
" \   'json': ['prettier'],
" \   'sh': ['shfmt'],
" \   '*': ['remove_trailing_lines', 'trim_whitespace'],
" \}

" " sorry i have to say gofmt is the least-useful formatter
" let g:ale_fix_on_save = 0

" " cland options
" " NOTE: it does not work if you use clangd.
" let g:ale_cpp_clangd_options = ''

" " clangformat options
" let g:ale_c_clangformat_options = '-style="{BasedOnStyle: Google, DerivePointerAlignment: false, PointerAlignment: Right, ColumnLimit: 120}"'
" let g:ale_cpp_clangformat_options = '-style="{BasedOnStyle: Google, DerivePointerAlignment: false, PointerAlignment: Right, ColumnLimit: 120}"'


" ===
" === airline
" ===

let g:airline_theme = 'gruvbox'
" let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#coc#error_symbol = 'Error:'
let g:airline#extensions#coc#warning_symbol = 'Warning:'
let g:airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let g:airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
let g:airline#extensions#branch#enabled = 1

" tagbar integration is useful, f can expose the full hierarchy.
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'

let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#nerdtree_statusline = 1

let g:airline_theme = 'base16_gruvbox_dark_hard'


" TODO: display only current used buffer.
" let g:airline#extensions#tabline#enabled = 1


" ===
" === easymotion
" ===
let g:EasyMotion_do_mapping = 1 " Enable default mappings


" ===
" === gitgutter
" ===

set updatetime=100


" ===
" === indentlint
" ===

let g:indentLine_enabled = 0


" ===
" === NERDTree
" ===

" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" donot display hidden file in nerdtree
let NERDTreeShowHidden = 0

" open/close NERDTree with <Ctrl-n>
nmap <C-n> :NERDTreeToggle<CR>

" change the CWD in each tab as the root dir of tab is changed.
let g:NERDTreeChDirMode = 2

" Making it prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 25


" ===
" === autopairs
" ===

let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = ',b'

" ===
" === rainbow
" ===

" to avoid some bugs when use rainbow and devicons simultaneously.
" see bracket issue https://github.com/ryanoasis/vim-devicons/issues/327
let g:rainbow_conf = {
  \    'guifgs': ['darkorange3', 'seagreen3', 'firebrick', 'royalblue3'],
  \    'ctermfgs': ['lightyellow', 'lightcyan', 'lightmagenta', 'lightblue'],
  \    'separately': {
  \       'nerdtree': 0
  \    }
  \}
let g:rainbow_active = 1 " 0 if you want to enable it later via :RainbowToggle


" ===
" === tagbar
" ===
nmap <C-b> :TagbarToggle<CR>
let g:tagbar_iconchars = ['▸', '▾']


" ===
" === vimtex
" ===

" thanks to https://castel.dev/post/lecture-notes-1/
let g:vimtex_enabled=1
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
" TODO: add conceal plugin for vimtex.


" ===
" === Leaderf
" ===

let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
nnoremap <leader>w :LeaderfFunction<CR>

" FIXME: leaderf rg does not work, it stucks when opened.
" nnoremap <leader>e :Leaderf rg<CR>
nnoremap <leader>r :Leaderf mru<CR>

" it's expensive to use gtags and my machine is ringing away.
let g:Lf_GtagsAutoGenerate = 1
nnoremap <leader>e :Leaderf bufTag<CR>
nnoremap <leader>g :Leaderf gtags<CR>
let g:Lf_Gtagslabel = 'default'

" exclude while indexing.
let g:Lf_WildIgnore = {
        \ 'dir': ['.svn','.git','.hg', 'build', '.idea', 'cmake-build-debug'],
        \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so', '*.dylib', '*.py[co]', '.DS_Store']
        \}

" ===
" === termdebug
" ===

" NOTE that after you quit from termbug, you are not under relative number mode
" but you can set it by manual through command :set relativenumber.
nnoremap <leader>t :set relativenumber!<CR> :packadd termdebug<CR> :Termdebug<CR>


" ===
" === UltiSnips
" ===

" Trigger configuration. You need to change this to something else than <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" ===
" === coc.nvim
" ===

let g:coc_global_extensions = ['coc-vimlsp', 'coc-json', 'coc-clangd', 'coc-python', 'coc-sql', 'coc-sh', 'coc-cmake']
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

set updatetime=100
set shortmess+=c

" use <c-o> to trigger completion.
inoremap <silent><expr> <c-o> coc#refresh()

" use <cr> to comfirm completion.
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `<C-k>` and `<C-j>` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <C-h> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' .  visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@


" NOTE: I tried to use undotree plugin, but it cause a little stall when I
" turn to command mode.

" TODO: modify the image.vim plugin to show image inside vim.


" ===
" === previm
" ===
let g:previm_open_cmd = 'open -a Google\ Chrome'
