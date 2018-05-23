" smartchr
inoremap <expr> = smartchr#one_of('=', ' = ', ' == ', ' => ')
inoremap <expr> ! smartchr#one_of('!', ' != ')
inoremap <expr> + smartchr#one_of('+', ' + ', ' += ')
inoremap <expr> - smartchr#one_of('-', ' - ', ' -= ')
inoremap <expr> , smartchr#one_of(',', ', ')


let g:racer_cmd = "$HOME/.cargo/bin"
let g:racer_experimental_completer = 1
