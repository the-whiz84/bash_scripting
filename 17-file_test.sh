#!/bin/bash

# For provided file print the summary of what permissions user has granted
# Example: ./file_test.sh hello.txt
# READ: YES
# WRITE: NO
# EXECUTE: NO

# Argument check
if [ $# -ne 1 ]; then
  echo "Provide exactly one argument"
  exit 1
fi

# Variable assignment
FILE=$1

# Check if file exists and permissions
if [ -f $FILE ]; then
  #default variables
  VAR_READ="NO"
  VAR_WRITE="NO"
  VAR_EXE="NO"

  #check if file is readable
  if [ -r $FILE ]; then
    VAR_READ="YES"
  fi

  #check if file is writable
  if [ -w $FILE ]; then
    VAR_WRITE="YES"
  fi

  #check if file is executable
  if [ -x $FILE ]; then
    VAR_EXE="YES"
  fi

  #Write permissions summary to user
  echo "===FILE: $FILE ==="
  echo "READ: $VAR_READ"
  echo "WRITE: $VAR_WRITE"
  echo "EXECUTABLE: $VAR_EXE"

elif [ -d $FILE ]; then
  echo "$FILE is a directory."

else
  echo "$FILE does not exist"
fi