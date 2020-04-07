"   _____  _             _
"  |  __ \| |           (_)
"  | |__) | |_   _  __ _ _ _ __  ___
"  |  ___/| | | | |/ _` | | '_ \/ __|
"  | |    | | |_| | (_| | | | | \__ \
"  |_|    |_|\__,_|\__, |_|_| |_|___/
"                   __/ |
"                  |___/
" by randomowo

call plug#begin('~/.config/vim/vimconf/plugins')
" theme
" Plug 'arcticicestudio/nord-vim'
Plug 'dylanaraps/wal.vim'

" LaTex
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" developing plugins
Plug 'sheerun/vim-polyglot'
Plug 'Valloric/YouCompleteMe'
Plug 'dense-analysis/ale'
Plug 'Chiel92/vim-autoformat'
Plug 'joereynolds/vim-minisnip'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'majutsushi/tagbar'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'ap/vim-css-color'

" Rust dev
Plug 'rust-lang/rust.vim'

" JVM dev
Plug 'tfnico/vim-gradle'
Plug 'udalov/kotlin-vim'

" Python dev

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'sjl/gundo.vim'

Plug 'itchyny/lightline.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

call plug#end()
