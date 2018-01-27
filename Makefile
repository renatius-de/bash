SOURCE = ${HOME}/.dotfiles/bash

clean:
	rm -f ${HOME}/.bash_logout
	rm -f ${HOME}/.bash_profile
	rm -f ${HOME}/.bashrc
	rm -f ${HOME}/.liquidpromptrc
	rm -fr LiquidPrompt

install:
	git clone git://github.com/nojhan/liquidprompt.git LiquidPrompt
	ln -snf ${SOURCE}/bash_logout ${HOME}/.bash_logout
	ln -snf ${SOURCE}/bash_profile ${HOME}/.bash_profile
	ln -snf ${SOURCE}/bashrc ${HOME}/.bashrc
	ln -snf ${SOURCE}/liquidpromptrc ${HOME}/.liquidpromptrc
