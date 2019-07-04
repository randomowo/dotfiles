" General
set relativenumber
set number
set linebreak
set showbreak=+++
set textwidth=120
set colorcolumn=120
highlight ColorColumn ctermbg=darkgray
set showmatch
set visualbell
set nocompatible
syntax on
filetype plugin on
set path+=**
set wildmenu

set hlsearch
set smartcase
set ignorecase
set incsearch

set autoindent
set cindent
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=2

set exrc
set secure

" Advanced
set ruler

set undolevels=1000
set backspace=indent,eol,start

" Plugins
call plug#begin('$HOME/.vim/plugins')

" theme
Plug 'ajh17/spacegray.vim'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" developing plugins
Plug 'Valloric/YouCompleteMe'
Plug '/scrooloose/syntastic'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'Chiel92/vim-autoformat'
Plug 'nathanaelkane/vim-indent-guides'

" Python dev
Plug 'klen/python-mode'

" Rust dev
Plug 'rust-lang/rust.vim'

" JVM dev
Plug 'tfnico/vim-gradle'
Plug 'udalov/kotlin-vim'
Plug 'ervandew/eclim'

"git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'easymotion/vim-easymotion'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" plugins conf
" colorscheme
set background=dark
colorscheme spacegray

" ale
let g:ale_fix_on_save = 1
let g:ycm_global_ycm_extra_conf = '/Users/randomowo/.vim/plugins/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" airline
let g:airline_theme = 'deus'
let g:airline_section_y = '%{system("if [[ -f /tmp/spotify-track ]]; then cat /tmp/spotify-track; fi")}'
let g:airline#extensions#tabline#enabled = 1
" format file after save
au BufWrite * :Autoformat
" indent guilines
let g:indent_guides_enable_on_vim_startup = 1

" wm func
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if(t:curwin == winnr())
	if(match(a:key,'[jk]'))
	    wincmd v
	else
	    wincmd s
	endif
	exec "wincmd ".a:key
    endif
endfunction

" start spotify status 'deamon'
:call system('$DOT/bin/spotify/startspotify')
au QuitPre : call system('$DOT/bin/spotify/killspotify')

" mappings
map <C-n> :NERDTreeToggle<CR>
map <Leader> <Plug>(easymotion-prefix)

" keys for wm
map <silent> <C-j> :call WinMove('j')<CR>
map <silent> <C-k> :call WinMove('k')<CR>
map <silent> <C-h> :call WinMove('h')<CR>
map <silent> <C-l> :call WinMove('l')<CR>

