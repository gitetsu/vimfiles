scriptencoding utf-8

set nocompatible
filetype off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'git://github.com/vim-scripts/BlockDiff.git'
Plugin 'git://github.com/Lokaltog/vim-easymotion.git'
Plugin 'git://github.com/vim-scripts/The-NERD-tree.git'
Plugin 'git://github.com/vim-scripts/YankRing.vim.git'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'kien/tabman.vim'
Plugin 'git://github.com/vim-scripts/dbext.vim.git'
Plugin 'git://github.com/bkad/CamelCaseMotion.git'
"Plugin 'git://github.com/tyru/operator-camelize.vim.git'
Plugin 'git://github.com/tpope/vim-endwise.git'
Plugin 'git://github.com/tpope/vim-fugitive.git'
Plugin 'git://github.com/vim-scripts/greplace.vim.git'
Plugin 'git://github.com/gregsexton/gitv.git'
Plugin 'git://github.com/vim-scripts/gtags.vim.git'
Plugin 'git://github.com/vim-scripts/matchit.zip.git'
Plugin 'git://github.com/tpope/vim-rails.git'
Plugin 'git://github.com/thinca/vim-ref.git'
Plugin 'git://github.com/thinca/vim-quickrun.git'
Plugin 'git://github.com/vim-scripts/scratch.vim.git'
Plugin 'scrooloose/syntastic'
Plugin 'git://github.com/kana/vim-smartchr.git'
Plugin 'git://github.com/kana/vim-smartinput.git'
Plugin 'git://github.com/tpope/vim-surround.git'
Plugin 'git://github.com/majutsushi/tagbar.git'
Plugin 'git://github.com/tomtom/tlib_vim'
Plugin 'git://github.com/int3/vim-extradite.git'
Plugin 'git://github.com/tpope/vim-repeat.git'
Plugin 'git://github.com/MarcWeber/vim-addon-mw-utils'
Plugin 'git://github.com/t9md/vim-textmanip.git'
Plugin 'git://github.com/Shougo/vimproc.git'
Plugin 'git://github.com/Shougo/vimshell.git'
Plugin 'itchyny/lightline.vim.git'
Plugin 'rhysd/clever-f.vim'
Plugin 'Shougo/neocomplcache'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'szw/vim-ctrlspace'

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
set nobackup
set hidden

" cmd settings
set wildmenu
set wildmode=longest,full
set formatoptions+=mM
set whichwrap=b,s,h,l
set laststatus=2
function! GetCurrentPasteStatus()
	if &paste == 0
		return ''
	elseif &paste == 1
		return '[paste]'
	endif
endfunction
set statusline=%<%F\ %m%r%h%w[%n]%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'.GetCurrentPasteStatus()}%=line:%l/%L\ col:%c%V%8P
set showcmd
set history=1000

" I pray I will never use these
if has('gui_win32')
  set shell=c:/cygwin/bin/bash\ --login
  set shellcmdflag=--login\ -c
endif

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
"auto completion for brackets
"inoremap ( ()<Left>
"inoremap [ []<Left>


" visual mode keymap
vmap / y/<C-R>"<CR>
vmap <C-a> <ESC>gg<S-v><S-g>
vmap <C-c> "+y
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l

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

" commands
" rename current buffer
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

" change current directory
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd ' . a:directory
  endif

  if a:bang == ''
    pwd
  endif
endfunction
nnoremap <silent><Space>cd :<C-u>CD<CR>

imap <silent><leader>date <ESC>:execute 'normal a'.strftime('%Y/%m/%d')<CR>a

"completeion from syntax higilight
if has("autocmd") && exists("+omnifunc")
autocmd Filetype *
        \   if &omnifunc == "" |
        \     setlocal omnifunc=syntaxcomplete#Complete |
        \   endif
endif

" ctrlp
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

" easymotion
let g:EasyMotion_leader_key = '<Leader>'


" gtags
nnoremap <Space>gd :Gtags <C-r><C-w><CR>
nnoremap <Space>gr :Gtags -r <C-r><C-w><CR>

" NERDTree
nnoremap <silent><Space>n :<C-u>NERDTreeToggle<CR>

" toggle_mouse
nnoremap <Space>m :<C-u>ToggleMouse<CR>

" Ref
let g:ref_alc_start_linenumber = 39
let g:ref_phpmanual_path = '$HOME/man/php-chunked-xhtml/'

" sparkup
"let g:sparkupExecuteMapping = '<c-m>'

if has('multi_byte_ime') || has('xim')
  set iminsert=0 imsearch=0
endif

" lightline
let g:lightline = {
	\ 'component_function': {
	\   'filename': 'MyFilename'
	\ }
	\ }

function! MyFilename()
  return ('' != expand('%:f') ? expand('%:f') : '[No Name]')
endfunction

" vim-textmanip
xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)

" neocomplecache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_ignore_case = 0

" neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" ctrlspace
let g:ctrlspace_default_mapping_key = '<Space>j'
if executable('ag')
	let g:ctrlspace_glob_command = 'ag -l --nocolor -g ""'
endif
hi link CtrlSpaceSearch Search
