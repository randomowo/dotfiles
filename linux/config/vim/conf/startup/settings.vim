"     _____      _   _   _
"    / ____|    | | | | (_)
"   | (___   ___| |_| |_ _ _ __   __ _ ___
"   \___ \ / _ \ __| __| | '_ \ / _` / __|
"   ____) |  __/ |_| |_| | | | | (_| \__ \
"  |_____/ \___|\__|\__|_|_| |_|\__, |___/
"                                __/ |
"                               |___/
" by randomowo

set number relativenumber
set wm=0
set linebreak
set textwidth=0
set wrapmargin=0
set colorcolumn=120
set fileformat=unix
set encoding=utf-8
set cmdheight=1
set shortmess+=c
set path+=*/*
set hlsearch
set smartcase
set incsearch
set cindent
set smarttab
set shiftwidth=4
set tabstop=4
set expandtab
set secure
set ruler
set list
set splitbelow
set splitright
set noswapfile
set nopaste
set nobackup nowritebackup

set completeopt=menu,menuone,noselect

syntax on
colorscheme gruvbox

" Files settings
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" make background transparent
hi! Normal ctermbg=NONE guibg=NONE

" Highlight extra whitespaces at the end
highlight ExtraWhitespace ctermbg=red guibg=red
au BufNew,BufEnter,BufWinEnter,WinEnter,BufNew * match ExtraWhitespace /\s\+$/


" ====Plugins====

" lightline && lightline#bufferline
autocmd VimEnter,BufWritePost,TextChanged,TextChangedI * call lightline#update()

let g:lightline = {
    \    'colorscheme': 'gruvbox',
    \    'active': {
    \        'left': [
    \            [ 'mode', 'paste' ],
    \            [ 'buffers' ]
    \        ],
    \        'right': [
    \            [ 'lineinfo' ],
    \            [ 'readonly' ],
    \            [ 'fileencoding', 'filetype' ],
    \            [ 'gitbranch' ]
    \        ]
    \    },
    \    'tabline': {
    \        'left': [ ['tabs'] ],
    \        'right': []
    \    },
    \    'component_type': {
    \        'buffers': 'raw',
    \    },
    \    'component_expand': {
    \        'buffers': 'bufferline#refresh_status().bufferline#get_status_string'
    \    },
    \    'component_function': {
    \        'gitbranch': 'GetBranchName',
    \    },
    \}

" buffline
let g:bufferline_echo = 0
let g:bufferline_show_bufnr = 0
let g:bufferline_pathshorten = 1
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
let g:bufferline_modified = '*'
let g:bufferline_unnamed = '[No Name]'
let g:bufferline_separator = ' '
let g:bufferline_solo_highlight = 1

" minisnip
let g:minisnip_trigger = '<S-Tab>'
let g:minisnip_dir = '~/.config/vim/vimconf/minisnip'

" markdown-preview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 1

" ranger
let g:ranger_map_keys = 0

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
hi IndentGuidesEven ctermbg=black
hi IndentGuidesOdd ctermbg=darkgrey

" GitGutter
let g:gitgutter_highlight_linenrs = 1
let g:gitgutter_preview_win_floating = 1

" Tagbar
let g:tagbar_ctags_bin = '/opt/homebrew/bin/ctags'

" ALE
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 0
let g:ale_linters = {
    \ 'python' : ['flake8', 'pylint'],
\}
let b:ale_fixers = {
    \ 'python': ['black', 'isort', 'autopep8', 'yapf', 'reorder-python-imports']
\}


