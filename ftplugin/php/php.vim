set noexpandtab

" smartchr
inoremap <expr> = smartchr#one_of('=', ' = ', ' == ', ' => ', ' === ')
inoremap <expr> ! smartchr#one_of('!', ' != ', ' !== ')

" Ref
let g:ref_phpmanual_path = $HOME . '/man/php-chunked-xhtml/'
let g:ref_phpmanual_cmd = 'w3m -dump %s'
