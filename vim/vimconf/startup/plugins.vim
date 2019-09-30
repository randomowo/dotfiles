"   _____  _             _           
"  |  __ \| |           (_)          
"  | |__) | |_   _  __ _ _ _ __  ___ 
"  |  ___/| | | | |/ _` | | '_ \/ __|
"  | |    | | |_| | (_| | | | | \__ \
"  |_|    |_|\__,_|\__, |_|_| |_|___/
"                   __/ |            
"                  |___/             
" by randomowo

call plug#begin('$HOME/.vim/plugins')
" theme
" Plug 'arcticicestudio/nord-vim'
Plug 'dylanaraps/wal.vim'

" LaTex
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'lervag/vimtex'

" developing plugins
Plug 'Valloric/YouCompleteMe'
Plug 'vim-syntastic/syntastic'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'Chiel92/vim-autoformat'
Plug 'joereynolds/vim-minisnip'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'majutsushi/tagbar'

" Rust dev
Plug 'rust-lang/rust.vim'

" JVM dev
Plug 'tfnico/vim-gradle'
Plug 'udalov/kotlin-vim'

"git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
