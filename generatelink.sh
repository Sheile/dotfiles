#!/bin/sh

cd $(dirname $0)
if [ ! -d backup ]
then
    mkdir backup
fi

for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
    then
        if [ -f "$HOME/$dotfile" ] && [ ! -L "$HOME/$dotfile" ]
        then
            mv "$HOME/$dotfile" "$PWD/backup"
        fi
        ln -Fs "$PWD/$dotfile" $HOME
    fi
done
