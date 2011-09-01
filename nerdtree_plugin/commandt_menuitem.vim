if exists("g:loaded_nerdtree_commandt")
  finish
endif
let g:loaded_nerdtree_commandt = 1

call NERDTreeAddMenuItem({'text': '(t)execute CommandT current directory', 'shortcut': 't', 'callback': 'NERDTreeCommandT'})

function! NERDTreeCommandT()
    let curDirNode = g:NERDTreeDirNode.GetSelected()

    exec 'CommandT' . curDirNode.path.str()
endfunction
