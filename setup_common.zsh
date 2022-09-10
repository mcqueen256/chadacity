#!/bin/zsh

if [[ $SHELL != *zsh ]]
then
    echo "This script must be run with zsh."
    exit 1
fi

git config --global user.name "Nicholas Buckeridge"
git config --global user.email bucknich@gmail.com
git config --global core.editor vim

mkdir -p ~/bin



