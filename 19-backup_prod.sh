#!/bin/bash

# Backup all .pdf files from prod location:
#(/Users/wizard/Developer/bash_scripting/19-Backup_Script_Files/prod) - your location

# Script takes one argument: destination path which needs to end with '/backup'
# e.g. /Users/wizard/Developer/bash_scripting/19-Backup_Script_Files/backup


PROD=/Users/wizard/Developer/bash_scripting/19-Backup_Script_Files/prod

# Argument check
if [ $# -ne 1 ]; then
  echo "Only one argument is needed, run $0 destination-path"
  exit 1
fi

# Destination path check
DESTINATION=$1

if [[ $DESTINATION != */backup ]]; then
  echo "Wrong destination path. Destination path must end with /backup"
  exit 2
fi

# Create destination folder
DATE=$(date +%Y-%m-%d_%H_%M_%S)
mkdir -p $DESTINATION/$DATE

# Copy from prod to destination
cp $PROD/*.pdf $DESTINATION/$DATE

# test exit status of copy command
if [ $? -eq 0 ]; then
  echo Backup OK
else
  echo Backup failed
fi
