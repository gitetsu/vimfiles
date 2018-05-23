" smartchr
inoremap <expr> = smartchr#one_of('=', ' = ', ' == ', ' => ', ' === ')
inoremap <expr> ! smartchr#one_of('!', ' != ', ' !== ')
inoremap <expr> + smartchr#one_of('+', ' + ', ' += ')
inoremap <expr> - smartchr#one_of('-', ' - ', ' -= ')
inoremap <expr> . smartchr#one_of('.', ' . ')
inoremap <expr> , smartchr#one_of(',', ', ')

" Ref
let g:ref_phpmanual_path = $HOME . '/man/php-chunked-xhtml/'
let g:ref_phpmanual_cmd = 'w3m -dump %s'

let g:php_sql_query = 1
let g:php_htmlInStrings = 1
"let php_noShortTags=1
let g:php_folding = 1
let g:php_large_file = 5000
