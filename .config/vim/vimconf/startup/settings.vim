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
set encoding=utf-8
set path+=*/*
set hlsearch
set smartcase
set incsearch
set cindent
set shiftwidth=4
set smarttab
set softtabstop=4
set tabstop=4
set secure
set exrc
set ruler
set undolevels=100
set list
set listchars+=tab:<\ >
set splitbelow
set splitright
set noswapfile
syntax on
colorscheme wal

" ====Plugins====

" YcM
let g:ycm_key_list_select_completion = ['<F2>', '<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

" LaTex
let g:livepreview_previewer = 'zathura'
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0

" ale
let g:ale_fix_on_save = 0
let g:ale_linters = {'python' : ['flake8', 'pylint']}
let b:ale_fixers = {
			\'python': ['black', 'isort', 'autopep8', 'yapf', 'reorder-python-imports'],
			\'c': ['uncrustify'],
			\'latex': ['textlint']}

" airline
let g:airline_theme = 'wal'
let g:airline#extensions#tabline#enabled = 1

" minisnip
let g:minisnip_trigger = '<S-Tab>'
let g:minisnip_dir = '~/.config/vim/vimconf/minisnip'

" markdown-preview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 1

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" indetLine
let g:indentLine_enabled = 1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_setColors = 0
