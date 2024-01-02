#!/bin/bash
filelist=$(find ./docs -type f -name "*.md")
pattern='```'


for file in $filelist
do
    for line in $(grep -Fn $pattern $file | sed -e's/:.*//' | sed -n 'n;p')
    do
        if  ! [[ $(awk "NR==$line+1" $file) == *"{ data-search-exclude }"* ]]; then
            echo "Snippet in line $line in file $file is not excluded from search" >> status.txt
        fi
    done
done

if [ -s "status.txt" ]  || [ -f "status.txt" ] ;then
    cat status.txt
    exit 7
fi

