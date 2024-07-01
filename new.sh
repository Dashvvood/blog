#!/bin/bash
semester=S1

last=content/posts/$semester/last.md 

if [ $# -eq 2 ] && [ "$1" = "leaf" ]; then
    # Code to execute when "leaf" parameter is provided
    hugo new content content/posts/$semester/$2/index.md --kind leaf

    if [ -L $last ]; then
        rm $last
        ln -s ./$2/index.md $last
    else
        ln -s ./$2/index.md $last
    fi

    typora content/posts/$semester/$2/index.md &

else
    # Code to execute when "leaf" parameter is not provided
    hugo new content content/posts/$semester/$1.md --kind leaf
    if [ -L $last ]; then
        rm $last
        ln -s ./$1.md $last
    else
        ln -s ./$1.md $last
    fi
    typora content/posts/$semester/$1.md &
fi