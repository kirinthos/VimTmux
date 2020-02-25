set hidden
execute pathogen#infect()

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
" set a new leader key
nnoremap , ;
let mapleader = ";"

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

" indentation
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab

" set folding mode to syntax
set foldmethod=syntax
set foldlevel=99

" map jk in insert mode to escape so I don't have to leave typing row
inoremap jk <esc>

" map old WordStar ctrl + a/e to begin/end of line
imap <C-a> <esc>0i
imap <C-e> <esc>$a
nmap <C-a> 0
nmap <C-e> $

" switching panes using vim navigation keys
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" and switching tabs
nnoremap <leader>ot : tabe %<CR>
nnoremap <C-i> :tabp<CR>
nnoremap <C-o> :tabn<CR>
" more natural split settings
set splitbelow
set splitright

" map w to word back word
map w b

" autocomplete color adjustments
hi Pmenu ctermbg=darkgrey ctermfg=green 

" sync files to trustedpath through syncr
nnoremap <leader>r :Suplfil<CR>:redraw!<CR>

" ctags in status line
let g:ctags_statusline=1 

" nerdtree key
nmap <C-n> :NERDTreeToggle<CR>
" close vim if nerdtree is only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" close nerdtree after opening file
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 50

" tagbar key
nnoremap <leader>tt :TagbarOpenAutoClose<CR>
nnoremap <leader>to :TagbarToggle<CR>

" ctrlp configuration
let g:ctrlp_match_window = 'min:1,max:10,results:10'
let g:ctrlp_match_func = {'match': 'pymatcher#PyMatch'}
let g:ctrlp_custom_ignore = {
	\ 'dir': '\v[\/]\.?(git|hg|docs|build|third-party)$'
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

" lusty explorer stuffs
nmap <F2> :LustyBufferExplorer<CR>
imap <F2> <esc>:LustyBufferExplorer<CR>
nmap <leader>b :LustyBufferExplorer<CR>

" map leader q to quick scope toggle
nmap <leader>q <plug>(QuickScopeToggle)
vmap <leader>q <plug>(QuickScopeToggle)

" YouCompleteMe extra file
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_enable_diagnostic_signs = 0
" turn on or off YCM with leader
nnoremap <leader>y :let g:ycm_auto_trigger=0<CR>
nnoremap <leader>Y :let g:ycm_auto_trigger=1<CR>
" setup for supertab with ultisnips
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" setup ultisnips to work with supertab
let g:UltiSnipsListSnippets = "<C-u>"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" super tag configuration
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = '<C-n>'
"let g:SuperTabCrMapping = 0

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

" map the JSON tool from python to <leader>fj
nmap <Leader>fj :%!python -m json.tool<CR>

" change cpp-enhanced-highlight class scope
let g:cpp_class_scope_highlight = 1

" ipdb breakpoint insertion
nnoremap <leader>pb Oimport ipdb; ipdb.set_trace()<esc>
