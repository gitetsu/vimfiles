scriptencoding utf-8

set nocompatible
filetype off

" Vundle
set rtp+=~/.vim/vundle.git/
call vundle#rc()

Bundle 'BlockDiff'
Bundle 'Command-T'
Bundle 'EasyMotion'
Bundle 'NERD_Tree-and-ack'
Bundle 'The-NERD-tree'
Bundle 'YankRing.vim'
Bundle 'ack.vim'
Bundle 'bufexplorer.zip'
Bundle 'ctrlp.vim'
Bundle 'git://github.com/vim-scripts/dbext.vim.git'
Bundle 'endwise.vim'
Bundle 'fugitive.vim'
Bundle 'git://github.com/gregsexton/gitv.git'
Bundle 'git://github.com/toritori0318/vim-nerdtree-plugin.git'
Bundle 'gtags.vim'
Bundle 'matchit.zip'
Bundle 'rails.vim'
Bundle 'ref.vim'
Bundle 'scratch.vim'
Bundle 'smartchr'
Bundle 'snipMate'
Bundle 'surround.vim'

set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,cp932,sjis,utf-8

" display settings
set number
set ruler
set list
set listchars=tab:>\ ,extends:_,trail:-,eol:<
set nowrap
set ambiwidth=double
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
set shiftwidth=4
set softtabstop=4
set tabstop=4
set noexpandtab
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
set fileformats=unix,dos,mac

" cmd settings
set wildmenu
set wildmode=longest,full
set formatoptions+=mM
set whichwrap=b,s,h,l
set laststatus=2
set statusline=%<%F\ %m%r%h%w[%n]%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l/%L,%c%V%8P
set showcmd
set history=1000

filetype plugin indent on

" I pray I will never use these
if has('gui_win32')
  set shell=c:/cygwin/bin/bash\ --login
  set shellcmdflag=--login\ -c
endif

" key mappings
let mapleader = ","

" normal mode
nnoremap <leader>t :<C-u>tabnew<CR>
nnoremap <leader>p :<C-u>setlocal paste!<CR>
nnoremap <leader>P "*P
nnoremap <leader>C :<C-u>setlocal number!<CR>:<C-u>setlocal list!<CR>
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
inoremap ( ()<Left>
inoremap [ []<Left>


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
    execute 'lcd' . a:directory
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

" ack
nnoremap <Space>a :<C-u>Ack 

" ctrlp
let g:ctrlp_map = '<Space>p'
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_prompt_mappings = {
	\ 'PrtBS()': ['<C-h>'],
	\ 'PrtDelete()': ['<C-d>'],
	\ 'AcceptSelection("h")': ['<C-o>'],
	\ 'ToggleByFname()': ['<c-d>'],
	\ 'ToggleType(1)': ['<C-l>'],
	\ 'ToggleType(-1)': ['<C-h>'],
	\ 'PrtCurLeft()': ['<C-b>'],
	\ 'PrtCurRight()': ['<C-f>'],
	\ 'BufOpen("ControlP", "del")': ['<esc>', '<c-c>', '<c-g>'],
\ }

" CommandT
let g:CommandTMaxHeight=10
let g:CommandTBackspaceMap='<C-h>'
let g:CommandTDeleteMap='<C-d>'
let g:CommandTAcceptSelectionSplitMap='<C-o>'
let g:CommandTCursorLeftMap='<C-b>'
let g:CommandTCursorRightMap='<C-f>'
nnoremap <Space>t <ESC>:CommandT<CR>
nnoremap <Space>b <ESC>:CommandTBuffer<CR>


" gtags
nnoremap <Space>gd :Gtags <C-r><C-w><CR>
nnoremap <Space>gr :Gtags -r <C-r><C-w><CR>

" NERDTree
nnoremap <silent><Space>n :<C-u>NERDTreeToggle<CR>

" toggle_mouse
nnoremap <Space>m :<C-u>ToggleMouse<CR>

" Ref
let g:ref_alc_start_linenumber = 39

" sparkup
"let g:sparkupExecuteMapping = '<c-m>'

if has('multi_byte_ime') || has('xim')
  set iminsert=0 imsearch=0
endif
