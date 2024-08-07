#!/bin/bash

# List files starting with 1-9 .md in current directory
ls [1-9]-*.md
echo

# List files starting with 1-9 for both .sh and .md extensions
ls [1-9]-*.{md,sh}
echo

# List files starting with 5-15 .md
ls {[5-9],[1][0-5]}*.md
echo

# List all files with extension .md

ls *.md
