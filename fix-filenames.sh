#!/bin/bash
# script to fix filenames for dokuwiki

# status: hurt me plenty   <- make a BACKUP!

if [ "$1" = "--help" ] || [ ! -d "$1" ]; then
    echo "recursive search for files and apply dokuwiki compatible filenames"
    echo "usage:
    $0 /path/to/files/   -- for echoing actions
    $0 /path/to/files/ icanwin -- for backup of the folder to .bak
    $0 /path/to/files/ hurtmeplenty -- for fixing the filename
            "
    exit 1;
fi

action=${2-'echo'}
dir="$1"

[ $action = "hurtmeplenty" ] && action="mv"
[ $action = "icanwin" ] && cp -vrp $dir "$dir.bak" && exit 1
# cowardly doesnt check the action 

find $dir -type f | while read f; do

    a=$( basename "$f" )
    dir=$( dirname "$f" )
    b=`expr "xxx$a" : 'xxx\(.*\)' | sed 's/@/at/' | tr '[A-Z]' '[a-z]' | tr -cs '[:alnum:]_\-.\n' '_' `

    if [ "x$a" != "x$b" ]; then
        $action "$dir/$a" "$dir/$b";
    fi
  done

