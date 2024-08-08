#!/bin/bash

# Add a new line with current date and first 5 lines of ps command into all text files from current directory

for FILE in ./Test_Files/*.txt
do
  echo $(date) >> $FILE
  ps -ef | head -5 >> $FILE
  echo "=========" >> $FILE
done
