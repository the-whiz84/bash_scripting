#!/bin/bash

# Go through all arguments and print them to screen

COUNT=1

for ARG in "$@"
do
  echo "$COUNT. argument: $ARG"
  let COUNT++
done

