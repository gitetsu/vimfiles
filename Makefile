install:
	ln -fs `pwd`/vimrc ${HOME}/.vimrc
	ln -fs `pwd` ${HOME}/.vim
	git clone git://github.com/gmarik/Vundle.vim.git bundle/Vundle.vim
	vim +PluginInstall -c 'new bundle/BlockDiff/plugin/blockdiff.vim' -c 'set ff=unix' -c wqa

.PHONY: install
