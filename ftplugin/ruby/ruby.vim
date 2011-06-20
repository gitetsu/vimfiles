set expandtab
set shiftwidth=2

" smartchr
inoremap <expr> = smartchr#one_of('=', ' = ', ' == ', ' => ', ' += ')
inoremap <expr> { smartchr#one_of('{', '#{')
