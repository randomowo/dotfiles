"   __  __                   _             
"  |  \/  |                 (_)           
"  | \  / | __ _ _ __  _ __  _ _ __   __ _
"  | |\/| |/ _` | '_ \| '_ \| | '_ \ / _` |
"  | |  | | (_| | |_) | |_) | | | | | (_| |
"  |_|  |_|\__,_| .__/| .__/|_|_| |_|\__, |
"               | |   | |             __/ |    
"               |_|   |_|            |___/    

map bn :bn<CR>
map bd :bd<CR>
nmap <silent> <S-j> <C-d>
nmap <silent> <S-k> <C-u>
nmap <silent> sr :set spell spelllang=ru<CR>
nmap <silent> se :set spell spelllang=en<CR>
nmap <silent> ss :set nospell<CR>

map <silent> <C-j> :call WinMove('j')<CR>
map <silent> <C-k> :call WinMove('k')<CR>
map <silent> <C-h> :call WinMove('h')<CR>
map <silent> <C-l> :call WinMove('l')<CR>
nmap <F8> :TagbarToggle<CR>
nmap <F1> gg=G<CR>
