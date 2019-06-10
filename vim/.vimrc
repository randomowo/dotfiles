" General
set relativenumber	
set number
set linebreak	
set showbreak=\\	
set textwidth=120	
set colorcolumn=120
highlight ColorColumn ctermbg=darkgray
set showmatch	
set visualbell	
syntax on 

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

augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END

" Plugins
call plug#begin('$HOME/.vim/plugins')

" theme github
Plug 'flrnprz/plastic.vim'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" developing plugins
Plug 'Valloric/YouCompleteMe'
Plug '/scrooloose/syntastic'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/ctrlp.vim'

" git
Plug 'airblade/vim-gitgutter'

Plug 'easymotion/vim-easymotion'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='deus'

call plug#end()

" theme
set background=dark
colorscheme plastic

" windows 'manager'
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


" mappings

map <C-n> :NERDTreeToggle<CR>

" keys for wm
map <silent> <C-j> :call WinMove('j')<CR>
map <silent> <C-k> :call WinMove('k')<CR>
map <silent> <C-h> :call WinMove('h')<CR>
map <silent> <C-l> :call WinMove('l')<CR>


