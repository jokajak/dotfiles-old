#!/usr/bin/env bash

set -e

# Make backup(s) if nessesary then link new config to $HOME
function link_file {

    DIR="$2"
    SOURCE="$1"
    NAME="$(basename $SOURCE)"
    TARGET="$HOME/${NAME/_/.}"

    if [ -e "$TARGET" ]
    then
        BACKUP="$TARGET.bak"
        if [ -e "$BACKUP" ]
        then
            COUNT=0
            while [ -e "$BACKUP.$COUNT" ]; do let "COUNT += 1"; done
            BACKUP="$BACKUP.$COUNT"
        fi
        mv "$TARGET" "$BACKUP"
        echo "Backup file $BACKUP created."
    fi

    echo "Linking config file $TARGET."
    ln -s "$DIR"/"$SOURCE" "$TARGET"
}

# Make backup(s) if nessesary then copy new config to $HOME
function copy_file {

    SOURCE="$1"
    NAME="$(basename $SOURCE)"
    TARGET="$HOME/${NAME/_/.}"

    if [ -e "$TARGET" ]
    then
        BACKUP="$TARGET.bak"
        if [ -e "$BACKUP" ]
        then
            COUNT=0
            while [ -e "$BACKUP.$COUNT" ]; do let "COUNT += 1"; done
            BACKUP="$BACKUP.$COUNT"
        fi
        mv "$TARGET" "$BACKUP"
        echo "Backup file $BACKUP created."
    fi

    echo "Creating config file $TARGET."
    cp -r "$SOURCE" "$TARGET"
}


CWD="$(dirname $0)"
PWD=$(pwd)

DOTFILES="
_aliases
_bashrc
_screenrc
_shell-fu.bashrc
_vimrc
"
for DOTFILE in $(echo "$DOTFILES")
do
    if [ -d .git ]; then
        link_file "$DOTFILE" "$PWD"
    else
        wget https://github.com/jokajak/dotfiles/raw/master/"$DOTFILE" \
             -O "$CWD"/"$DOTFILE" --quiet --no-check-certificate
        copy_file "$DOTFILE"
    fi
done
