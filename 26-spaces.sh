#!/bin/bash

# ./spaces.sh [file-path] [-f or --fix remove spaces] [-h or --help usage]

function usage(){
    echo "USAGE: $0 [file-path] [-f or --fix remove spaces] [-h or --help usage]"
    exit 1
}

FIX=0  #0 - do not perform fix  1 - perform fix

if [ $# -eq 0 ]; then
    usage
fi

while [ $# -gt 0 ]
do
    case "$1" in
        -f|--fix )
            FIX=1
            shift
            ;;
        -h|--help )
            usage
            shift
            ;;
        * )
            if [ -f "$1" ]; then
                FILE="$1"
                shift
            else
                usage
            fi
            ;;
    esac

done

if [ $FIX -eq 1 ] && [ -f "$FILE" ]; then
    echo "Removing spaces and tabs at the beginning and end of lines."
    # sed -i 's/[[:blank:]]\+$//' "$FILE"
    # sed -i 's/^[[:blank:]]\+//' "$FILE"
# on MacOS I had to install and run gnu-sed which uses command gsed.    
    gsed -i 's/[[:blank:]]\+$//' "$FILE"
    gsed -i 's/^[[:blank:]]\+//' "$FILE"
fi

# Display graphically the spaces errors in the file
if [ -f "$FILE" ]; then
    # read command does not read spaces at beginning and end of line
    LINES=0
    REGEX_START="^[[:blank:]]+"
    REGEX_END="[[:blank:]]+$"

    while IFS= read -r line
    do
        let LINES++
        #if there is no space issue on the line, just print the line
        # echo "$line" | sed -e '/[[:blank:]]\+$/q9' -e '/^[[:blank:]]\+/q7' >/dev/null
        echo "$line" | gsed -e '/[[:blank:]]\+$/q9' -e '/^[[:blank:]]\+/q7' >/dev/null
        if [ $? -eq 0 ]; then
            printf %4s "$LINES:" >> temp.txt
            echo "$line" >> temp.txt
            continue
        fi

        # print line number with spaces errors
        printf %4s "$LINES:" >> temp.txt

        # print on the same line spaces/tabs as red background at the beginning of line
        if [[ "$line" =~ $REGEX_START ]]; then
            MATCH=`echo "$BASH_REMATCH" | gsed 's/\t/_TAB_/g'`
            #echo -e -n  "\e[41m$BASH_REMATCH\e[49m" >> temp.txt
            # does not work on MacOS
            # Replace \e with \033 - and separate BASH_REMATCH›
            #echo -e -n "\033[41m" $BASH_REMATCH "\033[49m\n" >> temp.txt
            echo -e -n  "\033[41m$MATCH\033[49m" >> temp.txt
        fi

        # print on the same line part of line which is correct
        echo -e -n "$line" | gsed -e 's/^[[:blank:]]\+//' -e 's/[[:blank:]]\+$//' >> temp.txt

        # print on the same line with red background where there are spaces or tabs at end of line
        if [[ "$line" =~ $REGEX_END ]]; then
            MATCH=`echo "$BASH_REMATCH" | gsed 's/\t/_TAB_/g'`
            echo -e -n  "\033[41m$MATCH\033[49m" >> temp.txt
        else
            echo >> temp.txt
        fi

    done < "$FILE"

    cat temp.txt
    rm temp.txt
fi

if [ $FIX -eq 1 ]; then
    echo
    echo -e "\033[42mDONE\033[49m"
fi
