scriptencoding utf-8

set nocompatible
filetype off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-abolish'
Plugin 'rking/ag.vim'
Plugin 'vim-scripts/BlockDiff'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'gregsexton/gitv'
Plugin 'itchyny/lightline.vim'
Plugin 'vim-scripts/matchit.zip'
Plugin 'Shougo/neocomplcache'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'AndrewRadev/switch.vim'
Plugin 'majutsushi/tagbar'
Plugin 'vim-php/tagbar-phpctags.vim'
Plugin 'szw/vim-ctrlspace'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-endwise'
Plugin 'int3/vim-extradite'
Plugin 'tpope/vim-fugitive'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'adoy/vim-php-refactoring-toolbox'
Plugin 'thinca/vim-quickrun'
Plugin 'tpope/vim-rails'
Plugin 'thinca/vim-ref'
Plugin 'tpope/vim-repeat'
Plugin 'kana/vim-smartchr'
Plugin 'kana/vim-smartinput'
Plugin 'tpope/vim-surround'
Plugin 't9md/vim-textmanip'
Plugin 'gcmt/wildfire.vim'
Plugin 'LeafCage/yankround.vim'

call vundle#end()
filetype plugin indent on

if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
    " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

set fileformats=unix,dos,mac

if exists('&ambiwidth')
  set ambiwidth=double
endif

set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,cp932,sjis,utf-8

" display settings
set number
set ruler
set list
set listchars=tab:>\ ,extends:_,trail:-,eol:<
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
inoremap <C-j> <Down>
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

" lightline
let g:lightline = {
  \ 'component_function': {
  \   'filename': 'MyFilename'
  \ }
  \ }

function! MyFilename()
  return ('' != expand('%:f') ? expand('%:f') : '[No Name]')
endfunction

" nerdtree
nnoremap <silent><Space>n :<C-u>NERDTreeToggle<CR>

" neocomplecache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_ignore_case = 0

" neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" switch.vim
let g:switch_mapping = '<Space>s'
let g:switch_custom_definitions =
  \ [
  \   ['and', 'or'],
  \   ['===', '!==']
  \ ]

" tagbar
nnoremap <silent><Space>t :TagbarToggle<CR>

" vim-ctrlspace
let g:ctrlspace_default_mapping_key = '<Space>j'
if executable('ag')
  let g:ctrlspace_glob_command = 'ag -l --nocolor -g ""'
endif
highlight link CtrlSpaceSearch Search

" vim-easymotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_use_migemo = 1
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
nmap <Space>m <Plug>(easymotion-s2)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

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
