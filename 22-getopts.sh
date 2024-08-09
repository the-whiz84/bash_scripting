#!/bin/bash

while getopts a:b:cd param; do
    case $param in
        a ) echo "parameter 'a' with argument: $OPTARG"
            ;;
        b ) echo "parameter 'b' with argument: $OPTARG"
            ;;
        c ) echo "parameter 'c' selected (no colon, no argument)"
            ;;
        d ) echo "parameter 'd' selected"
            ;;
    esac

done