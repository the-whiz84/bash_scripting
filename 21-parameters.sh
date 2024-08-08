#!/bin/bash

# Creating script with parameters [-f file] [--file file] [-h help] [--help help]
# -f or --file will provide info about number of lines, words or characters
# -h or --help will provide usage message

while [ $# -gt 0 ]
do
    case "$1" in
        -h|--help )
            echo "USAGE: $0 -h help] [--help help] [-f file] [--file file]"
            shift  #throw away parameter
            exit 1
            ;;
        -f|--file )
            FILE=$2 #we assign it to argument $2 because $1 will be -f or --file
            if ! [ -f "$FILE" ]; then
                echo "File does not exist"
                exit 2
            fi

            LINES=`cat "$FILE" | wc -l`
            WORDS=`cat "$FILE" | wc -w`
            CHARACTERS=`cat "$FILE" | wc -m`

            echo "===File: $FILE==="
            echo "Lines: $LINES"
            echo "Words: $WORDS"
            echo "Characters: $CHARACTERS"
            shift  #throw away parameter's argument
            shift  #throw away parameter's value
            ;;
        * )
            echo "USAGE: $0 -h help] [--help help] [-f file] [--file file]"
            exit 1
            ;;
    esac
# While loop will run forever as long as more than 0 arguments are provided so we need to use "shift" to decrease number
#of arguments
done
