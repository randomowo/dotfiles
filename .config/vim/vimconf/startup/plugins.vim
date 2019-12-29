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
Plug 'vim-syntastic/syntastic'
Plug 'kien/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'Chiel92/vim-autoformat'
Plug 'joereynolds/vim-minisnip'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'majutsushi/tagbar'
Plug 'terryma/vim-multiple-cursors'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-surround'

" Rust dev
Plug 'rust-lang/rust.vim'

" JVM dev
Plug 'tfnico/vim-gradle'
Plug 'udalov/kotlin-vim'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
