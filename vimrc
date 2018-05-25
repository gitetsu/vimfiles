" encodings
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp
set fileformats=unix,dos,mac
scriptencoding utf-8

set nocompatible

" vim-plug
call plug#begin('~/.vim/plugged')

" plugins
Plug 'tpope/vim-abolish'
Plug 'rking/ag.vim'
Plug 'DataWraith/auto_mkdir'
Plug 'tyru/caw.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'arecarn/fold-cycle.vim'
Plug 'gregsexton/gitv'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'itchyny/lightline.vim'
Plug 'AndrewRadev/linediff.vim'
Plug 'vim-scripts/matchit.zip'
Plug 'Shougo/neocomplcache'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'scrooloose/nerdtree'
Plug 'chrisbra/NrrwRgn'
Plug 'kannokanno/previm'
Plug 'AndrewRadev/sideways.vim'
Plug 'scrooloose/syntastic'
Plug 'AndrewRadev/switch.vim'
Plug 'majutsushi/tagbar'
Plug 'vim-php/tagbar-phpctags.vim'
Plug 'wellle/targets.vim'
Plug 'rhysd/try-colorscheme.vim'
Plug 'osyo-manga/vim-anzu'
Plug 'szw/vim-ctrlspace'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-endwise'
Plug 'tommcdo/vim-exchange'
Plug 'int3/vim-extradite'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ludovicchabant/vim-gutentags'
Plug 'thinca/vim-localrc'
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'adoy/vim-php-refactoring-toolbox'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-rails'
Plug 'thinca/vim-ref'
Plug 'tpope/vim-repeat'
Plug 'kana/vim-smartchr'
Plug 'kana/vim-smartinput'
Plug 'kana/vim-submode'
Plug 'tpope/vim-surround'
Plug 't9md/vim-textmanip'
Plug 'gcmt/wildfire.vim'
Plug 'othree/yajs.vim'
Plug 'LeafCage/yankround.vim'

" syntaxes
Plugin 'cespare/vim-toml'

call plug#end()

if exists('&ambiwidth')
  set ambiwidth=double
endif

" display settings
set number
set ruler
set list
set listchars=tab:▸\ ,extends:_,trail:-,eol:↩
set nowrap
set showtabline=2
set title

if &t_Co >= 256 || has("gui_running")
  " colorschme
  function! FixMolokai()
    highlight Visual ctermbg=55
    highlight IncSearch ctermfg=199 ctermbg=233
    highlight DiffAdd term=bold ctermbg=34
    highlight DiffDelete term=bold ctermbg=208

  endfunction

  augroup mycolor
    autocmd!
    autocmd ColorScheme * call FixMolokai()
  augroup END
  colorscheme molokai
endif

if &t_Co > 2 || has("gui_running")
  syntax on
endif

hi link ZenkakuSpace Error
match ZenkakuSpace /　/
autocmd VimEnter, WinEnter * match ZenkakuSpace /　/

" indent settings
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set cindent

" search settings
set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault

" edit settings
set backspace=indent,eol,start
set wrapscan
set showmatch
set matchtime=1
set nobackup
set backupskip=/tmp/*,/private/tmp/*
set hidden
set pumheight=10
set nrformats=

" cmd settings
set wildmenu
set wildmode=longest,full
set formatoptions+=mM
set whichwrap=b,s,h,l
set laststatus=2
set showcmd
set history=1000

" key mappings
let mapleader = ","

" normal mode
nnoremap <leader>t :<C-u>tabnew<CR>
nnoremap <silent><leader>p :<C-u>setlocal paste!<CR>
nnoremap <leader>P "*P
nnoremap <silent><leader>C :<C-u>setlocal number!<CR>:<C-u>setlocal list!<CR>
nnoremap <expr> s* ':%s/\<' . expand('<cword>') . '\>/'
nnoremap Y y$
nnoremap j gj
nnoremap k gk

" insert mode mappings
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" undo
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" Visual and select
vmap / y/<C-R>"<CR>
vnoremap <C-a> <ESC>gg<S-v><S-g>
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l

" Visual only
xnoremap s :sort<CR>
xnoremap t :s/\s\+$//<CR>

" command mode
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-h> <Bs>
cnoremap <C-k> <Up>
cnoremap <C-l> <C-u>
cnoremap w!! w !sudo tee % >/dev/null

let php_sql_query=1
let php_htmlInStrings=1
"let php_noShortTags=1
let php_folding=1
let php_large_file=5000

" omni completion
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set filetype=xhtml
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

imap <silent><leader>date <ESC>:execute 'normal a'.strftime('%Y/%m/%d')<CR>a

"completeion from syntax higilight
if has("autocmd") && exists("+omnifunc")
autocmd Filetype *
        \   if &omnifunc == "" |
        \     setlocal omnifunc=syntaxcomplete#Complete |
        \   endif
endif

if has('multi_byte_ime') || has('xim')
  set iminsert=0 imsearch=0
endif

" plugins

" caw.vim
nmap <Space>c <Plug>(caw:i:toggle)
vmap <Space>c <Plug>(caw:i:toggle)

" ctrlp.vim
let g:ctrlp_map = '<Space>p'
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_prompt_mappings = {
  \ 'PrtBS()': ['<c-h>'],
  \ 'PrtDelete()': ['<c-d>'],
  \ 'AcceptSelection("h")': ['<c-o>'],
  \ 'ToggleByFname()': ['<c-g>'],
  \ 'ToggleType(1)': ['<c-l>'],
  \ 'ToggleType(-1)': ['<c-h>'],
  \ 'PrtCurLeft()': ['<c-b>'],
  \ 'PrtCurRight()': ['<c-f>'],
\ }

" fold-cycle.vim
let g:fold_cycle_default_mapping = 0
nmap <Tab> <Plug>(fold-cycle-open)
nmap <BS> <Plug>(fold-cycle-close)

" incsearch.vim
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:incsearch#auto_nohlsearch = 1
map n <Plug>(incsearch-nohl)<Plug>(anzu-n)
map N <Plug>(incsearch-nohl)<Plug>(anzu-N)
map * <Plug>(incsearch-nohl)<Plug>(anzu-star)
map # <Plug>(incsearch-nohl)<Plug>(anzu-sharp)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

let g:incsearch#separate_highlight = 1

augroup incsearch-keymap
  autocmd!
  autocmd VimEnter * call s:incsearch_keymap()
augroup END
function! s:incsearch_keymap()
  IncSearchNoreMap <C-n> <Over>(incsearch-next)
  IncSearchNoreMap <C-p> <Over>(incsearch-prev)
  IncSearchNoreMap <C-f> <Over>(incsearch-scroll-f)
  IncSearchNoreMap <C-b> <Over>(incsearch-scroll-b)
endfunction

let g:incsearch_cli_key_mappings = {
  \   "\<C-j>": "\<CR>",
  \ }

" incsearch-fuzzy.vim
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

" lightline
let g:lightline = {
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['readonly', 'filename', 'modified', 'anzu']
  \   ],
  \   'right': [
  \     ['lineinfo'],
  \     ['percent'],
  \     ['fileformat', 'fileencoding', 'filetype'],
  \     ['gutentags'],
  \   ]
  \ },
  \ 'component': {
  \   'lineinfo': '%3l/%3L:%-2v',
  \ },
  \ 'component_function': {
  \   'anzu': 'anzu#search_status',
  \   'filename': 'MyFilename',
  \   'gutentags': 'gutentags#statusline',
  \ }
  \ }

function! MyFilename()
  return ('' != expand('%:f') ? expand('%:f') : '[No Name]')
endfunction

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_ignore_case = 0

" neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" nerdtree
nnoremap <silent><Space>n :<C-u>NERDTreeToggle<CR>

" previm
let g:previm_open_cmd = 'open -a Firefox'
augroup previm
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

" switch.vim
let g:switch_mapping = '<Space>s'
let g:switch_custom_definitions =
  \ [
  \   ['and', 'or'],
  \   ['=', '!='],
  \   ['===', '!==']
  \ ]

" tagbar
nnoremap <silent><Space>t :TagbarToggle<CR>

" vim-anzu
augroup vim-anzu
  autocmd!
  autocmd CursorMoved,WinLeave,TabLeave * call anzu#clear_search_status()
augroup END

" vim-ctrlspace
let g:ctrlspace_default_mapping_key = '<Space>j'
if executable('ag')
  let g:ctrlspace_glob_command = 'ag -l --nocolor -g ""'
endif
highlight link CtrlSpaceSearch Search

" vim-easymotion
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0
let g:EasyMotion_use_migemo = 1
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_use_upper = 1
nmap <Space>m <Plug>(easymotion-s2)
map f <Plug>(easymotion-fl)
map t <Plug>(easymotion-tl)
map F <Plug>(easymotion-Fl)
map T <Plug>(easymotion-Tl)
map <Space>j <Plug>(easymotion-j)
map <Space>k <Plug>(easymotion-k)

" vim-gitgutter
let g:gitgutter_sign_added = '✓'
let g:gitgutter_sign_modified = '✱'
let g:gitgutter_sign_removed = '✗'
let g:gitgutter_sign_modified_removed = '✦'

" vim-operator-flashy
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
let g:operator#flashy#group = 'Visual'

" vim-php-namespace
nnoremap <Space>e :call PhpExpandClass()<CR>
nnoremap <Space>u :call PhpInsertUse()<CR>

" vim-ref
let g:ref_phpmanual_path = '$HOME/man/php-chunked-xhtml/'
let g:ref_source_webdict_sites = {
  \ 'weblio': {
  \   'url': 'http://ejje.weblio.jp/content/%s',
  \ }
\ }
let g:ref_source_webdict_sites.default = 'weblio'

" vim-submode
let g:submode_keep_leaving_key = 1
call submode#enter_with('changetab', 'n', '', 'gt', 'gt')
call submode#enter_with('changetab', 'n', '', 'gT', 'gT')
call submode#map('changetab', 'n', '', 't', 'gt')
call submode#map('changetab', 'n', '', 'T', 'gT')
call submode#enter_with('closeWindow', 'n', '', '<C-w>c', '<C-w>c')
call submode#map('closeWindow', 'n', '', 'c', '<C-w>c')

" vim-textmanip
xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)

" wildfire
nmap <Space>w <Plug>(wildfire-quick-select)

" yankround.vim
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
nmap <Space>h :CtrlPYankRound<CR>
