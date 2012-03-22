#!/bin/sh

cd $(dirname $0)
for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
    then
        ln -Fs "$PWD/$dotfile" $HOME
    fi
done
