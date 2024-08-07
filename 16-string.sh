#!/bin/bash

STR1="hello buddy"
STR2="Hello buddy"

if [ "$STR1" = "$STR2" ]; then
  echo equal
else
  echo not equal
fi

# STR1="hello buddy"
# STR2="hello buddy"

# if [[ $STR1 = $STR2 ]]; then
#   echo equal
# else
#   echo not equal
# fi
