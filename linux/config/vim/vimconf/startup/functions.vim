"   ______                _   _                 
"  |  ____|              | | (_)                
"  | |__ _   _ _ __   ___| |_ _  ___  _ __  ___ 
"  |  __| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
"  | |  | |_| | | | | (__| |_| | (_) | | | \__ \
"  |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/

" ====Windows manager====
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
