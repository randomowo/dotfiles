"   _____  _             _           
"  |  __ \| |           (_)          
"  | |__) | |_   _  __ _ _ _ __  ___ 
"  |  ___/| | | | |/ _` | | '_ \/ __|
"  | |    | | |_| | (_| | | | | \__ \
"  |_|    |_|\__,_|\__, |_|_| |_|___/
"                   __/ |            
"                  |___/             

call plug#begin('$HOME/.vim/plugins')

" theme
Plug 'chriskempson/base16-vim'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

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
Plug 'nathanaelkane/vim-indent-guides'
Plug 'joereynolds/vim-minisnip'

" Rust dev
Plug 'rust-lang/rust.vim'

" JVM dev
Plug 'tfnico/vim-gradle'
Plug 'udalov/kotlin-vim'

"git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'easymotion/vim-easymotion'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
