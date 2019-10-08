"     _____      _   _   _                 
"    / ____|    | | | | (_)                
"   | (___   ___| |_| |_ _ _ __   __ _ ___ 
"   \___ \ / _ \ __| __| | '_ \ / _` / __|
"   ____) |  __/ |_| |_| | | | | (_| \__ \
"  |_____/ \___|\__|\__|_|_| |_|\__, |___/
"                                __/ |    
"                               |___/     
" by randomowo

set relativenumber
set number
set linebreak
set showbreak=+^+
set textwidth=120
set colorcolumn=120
set showmatch
set encoding=utf-8
set path+=*/*
set wildmenu
set hlsearch
set smartcase
set incsearch
set autoindent
set cindent
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=2
set tabstop=4
set secure
set exrc
set ruler
set undolevels=1000
syntax on
colorscheme wal

" ====Plugins====

" YcM
let g:ycm_key_list_select_completion = ['<s-tab>', '<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

" LaTex
let g:livepreview_previewer = 'zathura'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0

" ale
let g:ale_fix_on_save = 1

" airline
let g:airline_theme = 'deus'
let g:airline#extensions#tabline#enabled = 1

" syntactic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_tex_checkers = ['lacheck']

" minisnip
let g:minisnip_trigger = '<Tab>'

" markdown-preview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 1
