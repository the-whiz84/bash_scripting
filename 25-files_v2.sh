#!/bin/bash

# ./files.sh [-l or --location location] [-e or --extension extension] [-s or --stats statistics] [-h or --help usage]

function usage() {
    echo "USAGE: $0 [-l or --location location] [-e or --extension extension] [-s or --stats statistics] [-h or --help usage]"
    echo "Examples:"
    echo "$0 -l /etc/ -e txt -s"
    echo "$0 -e img --stats"
    echo
    exit 1
}

LOC_SET=0     # 0 - location not set, use current location; 1 - location was given
STATS=0       # 0 - do not display stats;   1 - display stats

while [ $# -gt 0 ]
do
    case $1 in
        -l|--location )
            LOCATION="$2"
            if ! [ -d "$LOCATION" ]; then
                usage
            fi
            LOC_SET=1
            shift 2
            ;;
        -e|--extension )
            EXT="$2"
            shift 2
            ;;
        -s|--stats )
            STATS=1
            shift
            ;;
        -h|--help )
            shift
            usage
            ;;
        * )
            usage
            ;;
    esac

done

if [ $LOC_SET -ne 1 ]; then
    LOCATION=$(pwd)
fi

echo "Location: $LOCATION"

if [ "$EXT" != "" ]; then
    ls -l $LOCATION | awk '/^-/' | grep "\.$EXT$"&>/dev/null
    if [ $? -ne 0 ]; then
        echo "No file with extension: $EXT found"
        exit 2
    fi
    #Provide size of files with specific extension
    ls -l $LOCATION | awk '/^-/' | grep "\.$EXT$" | awk -v stats=$STATS -f ./25-size.awk
   
else
    ls -l $LOCATION | awk '/^-/' | awk -v stats=$STATS -f ./25-size.awk
 
fi
