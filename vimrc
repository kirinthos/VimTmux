set hidden

" syntax highlighting adjustments
set nocompatible
filetype plugin on

" set up proper backspace
set backspace=2 

" set up proper mouse with tmux
set mouse=a

" syntax highlighting
syntax on
set background=dark

" line number stuff
set number
hi LineNr ctermfg=brown

" line highlighting stuff
set nocursorline
"hi CursorLine cterm=bold ctermbg=NONE ctermfg=NONE

" trailing chars identifiers
set listchars=tab:>·,trail:·

" set colorscheme
colorscheme apprentice.own

" tell vim to look at parents for tags
set tags=.tags;/

" Note: to preserve original behavior on new systems, changing to space
" set a new leader key
" nnoremap , ;
nnoremap <SPACE> <Nop>
let mapleader = " "

" put all backup files in one place
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" set smartcase, using all lowercase is case insensitive search, any uppercase character it becomes sensitive
set ignorecase
set smartcase
set hlsearch " and highlight matches
set incsearch " show searches as i type
set showmatch " matching parens

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noselect: Do not select, force user to select one from the menu
" preview: show preview window and information
set completeopt=menuone,noselect,preview

" indentation
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab

" set folding mode to syntax
set foldmethod=syntax
set foldlevel=99

" more natural split settings
set splitbelow
set splitright

" map jk in insert mode to escape so I don't have to leave typing row
inoremap jk <esc>

" switching panes using vim navigation keys
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" and switching tabs
nnoremap <leader>to : tabe %<CR>
nnoremap <leader>tp :tabp<CR>
nnoremap <leader>tn :tabn<CR>

" map the JSON tool from python to <leader>fj
nmap <Leader>fj :%!python -m json.tool --indent=2<CR>

" navigate omnipopup with vim C-keys
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "C-j"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "C-k"

" neovim has highlight on yank
if has('nvim')
    au TextYankPost * silent! lua vim.highlight.on_yank()
endif

" yank some DOOM(emacs) configuration hotkeys
nmap <silent> <leader>hc :e ~/.vimrc<CR>
nmap <silent> <leader>hC :e ~/.vim/coc-settings.json<CR>
nmap <silent> <leader>hv :e ~/.vim/coc-config.vimrc<CR>


""""""""""""""""""""""""""""""""""""""""
"
" Plugins
"
""""""""""""""""""""""""""""""""""""""""

if has('nvim')
    call plug#begin(stdpath('data') . '/plugged')
else
    call plug#begin('~/.vim/plugged')
endif
Plug 'junegunn/fzf.vim'
Plug 'vim-test/vim-test'
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim'
Plug 'antoinemadec/coc-fzf'
Plug 'junegunn/vim-easy-align'
" colors
Plug 'whatyouhide/vim-gotham'
Plug 'cocopon/iceberg.vim'
Plug 'romainl/Apprentice'
" configuration of environments
Plug 'editorconfig/editorconfig-vim'
" language specifics
Plug 'rust-lang/rust.vim'
Plug 'arzg/vim-rust-syntax-ext'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components'
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Plugin configurations
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" nerdtree key
nmap <C-n> :NERDTreeToggle<CR>
" close vim if nerdtree is only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" close nerdtree after opening file
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 50

" tagbar key
nnoremap <leader>ct :TagbarOpenAutoClose<CR>

" reset easymotion so we can use <leader><leader>
nmap <leader>e <Plug>(easymotion-prefix)

"
" ctrlp configuration
"

" buffer searching
" nmap <leader>b :CtrlPBuffer<CR>
" let g:ctrlp_map = '<leader><leader>'
let g:ctrlp_match_window = 'min:1,max:10,results:10'
let g:ctrlp_custom_ignore = {
	\ 'dir': '\v[\/]\.?(git|hg|build|third-party|venv|target)$'
	\ }
let g:ctrlp_max_files = 10000
let g:ctrlp_max_depth = 30
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('rg')
    set grepprg=rg\ --color=never
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
elseif executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" map leader q to quick scope toggle
nmap <leader>q <plug>(QuickScopeToggle)
vmap <leader>q <plug>(QuickScopeToggle)

" airline settings
set laststatus=2 " always show airline
let g:airline_theme = "badwolf"
" unicode symbols
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#whitespace#enabled = 0

" easy-motion configuration
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" optional easymotion next/prev mappings (normal ones work) -- provides alternate highlighting and some other stuff
" map n <Plug>(easymotion-next)
" map N <Plug>(easymotion-prev)

let g:rustfmt_autosave = 1
let g:shfmt_fmt_on_save = 1

"
" vim-test configuration
"
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

"
" FZF configuration
"
let $FZF_DEFAULT_COMMAND = 'fd'
nmap <silent> <leader><leader>  :FZF<CR>
nmap <silent> <leader>sp        :Rg<CR>
nmap <silent> <leader>b         :Buffers<CR>

" load coc configuration
source ~/.vim/coc-config.vimrc
