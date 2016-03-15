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

" always show the status bar
set laststatus=2

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
set noexpandtab
set list listchars=tab:»·,trail:·

" set folding mode to syntax
set foldmethod=syntax
set foldlevel=99

" map jj in insert mode to escape so I don't have to leave typing row
inoremap jj <esc>

" switching panes using vim navigation keys
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" more natural split settings
set splitbelow
set splitright

" and switching windows
nnoremap <C-i> :tabp<CR>
nnoremap <C-o> :tabn<CR>
nnoremap <C-u> :tabedit %<CR>

" resizing windows using vim navigation keys
nmap <M-h> <C-w><
nmap <M-j> <C-w>-
nmap <M-k> <C-w>+
nmap <M-l> <C-w>>
" on OSX, use the character the meta-key combination generates
"nmap <leader>h <C-w>10<
"nmap <leader>j <C-w>10-
"nmap <leader>k <C-w>10+
"nmap <leader>l <C-w>10>

" map w to word back word
map w b

" autocomplete color adjustments
hi Pmenu ctermbg=darkgrey ctermfg=green 

" ctags in status line
let g:ctags_statusline=1 

" nerdtree key
nmap <C-n> :NERDTreeToggle<CR>
" close vim if nerdtree is only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" close nerdtree after opening file
let NERDTreeQuitOnOpen = 1

" tagbar key
nmap <leader>t :TagbarToggle<CR>
nmap <F8> :TagbarToggle<CR>
imap <F8> <esc>:TagbarToggle<CR>a

" ctrlp configuration
let g:ctrlp_match_window = 'min:1,max:20,results:50'
let g:ctrlp_custom_ignore = {
	\ 'dir': '\v[\/]\.?(git|hg|docs|build)$'
	\ }

" lusty explorer stuffs
nmap <F2> :LustyBufferExplorer<CR>
imap <F2> <esc>:LustyBufferExplorer<CR>
nmap <leader>b :LustyBufferExplorer<CR>

" YouCompleteMe extra file
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py.default'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_enable_diagnostic_signs = 0
" turn on or off YCM with leader
nnoremap <leader>y :let g:ycm_auto_trigger=0<CR>
nnoremap <leader>Y :let g:ycm_auto_trigger=1<CR>
" setup for supertab with ultisnips
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

" super tag configuration
let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = '<C-n>'
"let g:SuperTabCrMapping = 0

" ultisnips stuff
let g:UltiSnipsExpandTrigger="<C-g>"
let g:UltiSnipsJumpForwardTrigger="<C-e>"
let g:UltiSnipsJumpBackwardTrigger="<C-w>"

" airline settings
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
