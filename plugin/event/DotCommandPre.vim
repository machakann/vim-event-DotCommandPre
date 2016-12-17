" DotCommandPre.vim: Add an autocmd event triggered before dot command
" Maintainer : Masaaki Nakamura <mckn@outlook.jp>

" License    : NYSL
"              Japanese <http://www.kmonos.net/nysl/>
"              English (Unofficial) <http://www.kmonos.net/nysl/index.en.html>

if &compatible || exists("g:loaded_event_DotCommandPre")
	finish
endif
let g:loaded_event_DotCommandPre = 1

let s:count = 0
function! s:count() abort "{{{
	return s:count ? s:count : ''
endfunction
"}}}

" NOTE: Probably assigning register to dot command is not so popular.
noremap <SID>(dot) .
inoremap <SID>(dot) <Nop>
cnoremap <SID>(dot) <Nop>
noremap <expr> <SID>(count) <SID>count()
inoremap <SID>(count) <Nop>
cnoremap <SID>(count) <Nop>
nnoremap <silent> <SID>(doautocmd) :<C-u>call event#DotCommandPre#doautocmd('n')<CR>
nmap <silent> <Plug>(event-DotCommandPre) <SID>(doautocmd)<SID>(count)
nmap <silent> <Plug>(event-DotCommandPre+Dot) <Plug>(event-DotCommandPre)<SID>(dot)

if hasmapto('<Plug>(DotCommandPre)', 'v')
	xnoremap <expr> <SID>(CaptureVirtCol) visualrepeat#CaptureVirtCol()
	xnoremap <silent><script> <SID>(VisualRepeat) <SID>(CaptureVirtCol):<C-u>call event#DotCommandPre#visualrepeat()
	xnoremap <silent> <SID>(doautocmd) <Esc>:call event#DotCommandPre#doautocmd('x')<CR>
	xmap <silent> <Plug>(event-DotCommandPre) <SID>(doautocmd)<SID>(count)
	xmap <silent> <Plug>(event-DotCommandPre+Dot) <Plug>(event-DotCommandPre)<SID>(VisualRepeat)
endif

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set noet ts=4 sts=4 sw=4:
