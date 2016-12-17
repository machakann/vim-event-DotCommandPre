" DotCommandPre.vim: Add an autocmd event triggered before dot command

" Main function
function! event#DotCommandPre#doautocmd(mode) abort "{{{
	let s:count = a:mode ==# 'x' ? v:prevcount : v:count
	if exists('g:DotCommandPre')
		unlockvar! g:DotCommandPre
	else
		let g:DotCommandPre = {}
	endif
	let g:DotCommandPre.mode = a:mode
	let g:DotCommandPre.curpos = getcurpos()
	let g:DotCommandPre.view = winsaveview()
	lockvar! g:DotCommandPre
	if a:mode ==# 'x'
		normal! gv
	endif
	if exists('#User#DotCommandPre')
		doautocmd <nomodeline> User DotCommandPre
	endif
endfunction
"}}}

" This is a fxxking stupid workaround.
" NOTE: visualrepeat.vim should serve public keymapping like, <Plug>(RepeatDot)
function! event#DotCommandPre#visualrepeat() abort "{{{
	if !visualrepeat#repeat()
		echoerr visualrepeat#ErrorMsg()
		if &cmdheight == 1
			sleep 500m
		endif
		execute 'normal! gv'
	endif
endfunction
"}}}

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set noet ts=4 sts=4 sw=4:
