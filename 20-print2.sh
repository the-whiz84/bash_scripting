#!/bin/bash

# Create script for printing files, which will also display line numbers

# Argument check
if [ $# -ne 1 ]; then
  echo "Exactly one argument is needed, run: $0 file-path"
  exit 1
fi

#Check if provided argument is a file
if ! [ -f "$1" ]; then
  echo "File provided does not exist"
  exit 2
fi

FILENAME=$1
COUNT=1

cat "$FILENAME" |
while read line
do
  echo "$COUNT: $line"
  let COUNT++
done
