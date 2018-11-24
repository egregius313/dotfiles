#!/bin/bash

set_home () {
    if [ -z $2 ]
    then
        ln -s $DOTFILES/$1 ~/$1;
    else
        ln -s $DOTFILES/$1 ~/$2;
    fi
}

# Configure git
set_home gitignore .gitignore
set_home gitconfig .gitconfig

# Configure shell files

set_home .bashrc
set_home .zshrc
set_home .profile

# tmux

set_home .tmux.conf


# Configure .npmrc 


