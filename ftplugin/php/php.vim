let php_sql_query=1
let php_htmlInStrings=1
"let php_noShortTags=1
let php_folding=1
let php_large_file=5000

" smartchr
inoremap <expr> = smartchr#one_of('=', ' = ', ' == ', ' => ', ' === ')

" Ref
let g:ref_phpmanual_path = $HOME . '/man/php-chunked-xhtml/'
let g:ref_phpmanual_cmd = 'w3m -dump %s'
