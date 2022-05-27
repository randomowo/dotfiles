"   _____  _             _
"  |  __ \| |           (_)
"  | |__) | |_   _  __ _ _ _ __  ___
"  |  ___/| | | | |/ _` | | '_ \/ __|
"  | |    | | |_| | (_| | | | | \__ \
"  |_|    |_|\__,_|\__, |_|_| |_|___/
"                   __/ |
"                  |___/
" by randomowo

call plug#begin($VIMDOTDIR . '/conf/plugins')
" theme
Plug 'morhetz/gruvbox'

" visual
Plug 'ap/vim-css-color'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" better highlighting
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'

" LSP
Plug 'neovim/nvim-lspconfig'

" autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

" dev
Plug 'joereynolds/vim-minisnip'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'

" git
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-gitbranch'

" status line
Plug 'itchyny/lightline.vim'
Plug 'randomowo/vim-bufferline'

" ranger
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'


call plug#end()


lua << EOF
local vimdir = os.getenv('VIMDOTDIR')
package.path = package.path .. ';' .. vimdir .. "/conf/startup/scripts/?.lua"
require 'pcmp'
require 'plsp'
EOF
