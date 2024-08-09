#!/bin/bash

echo "All arguments: $@"
opts=`getopt -o a::b:cde --long file::,name:,help -- "$@"`
eval set -- "$opts"
echo "All arguments after getopt: $@"

while [ $# -gt 0 ]
do
    case "$1" in
        -a) echo "parameter 'a' selected with argument: $2"
            shift 2
            ;;
        -b) echo "parameter 'b' selected with argument: $2"
            shift 2
            ;;
        -c) echo "parameter 'c' selected"
            shift
            ;;
        -d) echo "parameter 'd' selected"
            shift
            ;;
        -e) echo "parameter 'e' selected"
            shift
            ;;
        --file) echo "parameter 'file' selected with argument: $2"
                shift 2
                ;;
        --name) echo "parameter 'name' selected with argument: $2"
                shift 2
                ;;
        --help) echo "parameter 'help' selected"
                shift
                ;;
        *)      echo "something else provided: $1"
                shift
                ;;
    esac

done
