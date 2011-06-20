
init:
	ln -s `pwd`/vimrc ${HOME}/.vimrc
	ln -s `pwd`/ ${HOME}/.vim

.PHONY: init
