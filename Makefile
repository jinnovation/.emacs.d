CASK ?= cask
EMACS ?= emacs

test:
	${CASK} exec ecukes
