"   __  __                   _
"  |  \/  |                 (_)
"  | \  / | __ _ _ __  _ __  _ _ __   __ _
"  | |\/| |/ _` | '_ \| '_ \| | '_ \ / _` |
"  | |  | | (_| | |_) | |_) | | | | | (_| |
"  |_|  |_|\__,_| .__/| .__/|_|_| |_|\__, |
"               | |   | |             __/ |
"               |_|   |_|            |___/

" tabs managing
map tc :tabnew<CR>
map tn :tabNext<CR>
map td :tabclose<CR>
map to :tabonlu<CR>

" buffer managing
map bn :bn<CR>
map bd :bd<CR>

nmap <silent> <S-j> <C-d>
nmap <silent> <S-k> <C-u>
nmap <silent> sr :set spell spelllang=ru<CR>
nmap <silent> se :set spell spelllang=en<CR>
nmap <silent> ss :set nospell<CR>
nmap <silent> cn :cn<CR>
nmap <silent> cp :cp<CR>
nnoremap ,<space> :nohlsearch<CR>

" window arrange
map <silent> <C-j> :call WinMove('j')<CR>
map <silent> <C-k> :call WinMove('k')<CR>
map <silent> <C-h> :call WinMove('h')<CR>
map <silent> <C-l> :call WinMove('l')<CR>

" window resize
noremap <silent> <A-Left> <C-w><<CR>
noremap <silent> <A-Right> <C-w>><CR>
noremap <silent> <A-Up> <C-w>+<CR>
noremap <silent> <A-Down> <C-w>-<CR>

" pluggins
map <F3> :Ranger<CR>
nmap <F8> :TagbarToggle<CR>

" file execute mappings
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

autocmd FileType javascript map <buffer> <F9> :w<CR>:exec '!node' shellescape(@%, 1)<CR>
autocmd FileType javascript imap <buffer> <F9> <esc>:w<CR>:exec '!node' shellescape(@%, 1)<CR>

autocmd FileType typescript map <buffer> <F9> :w<CR>:exec '!npx ts-node' shellescape(@%, 1)<CR>
autocmd FileType typescript imap <buffer> <F9> <esc>:w<CR>:exec '!npx ts-node' shellescape(@%, 1)<CR>

autocmd FileType go map <buffer> <F9> :w<CR>:exec '!go run' shellescape(@%, 1)<CR>
autocmd FileType go imap <buffer> <F9> <esc>:w<CR>:exec '!go run' shellescape(@%, 1)<CR>

" Git Gutter
nmap ghp <Plug>(GitGutterPreviewHunk)
nmap ghu <Plug>(GitGutterUndoHunk)

