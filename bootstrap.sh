#!/bin/zsh

emacs -batch --eval "(require 'ob-tangle)" --eval '(org-babel-tangle-file "README.org")'
