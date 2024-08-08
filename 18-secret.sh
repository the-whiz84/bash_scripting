#!/bin/bash

# echo -n Your age: 
# read AGE

# [ $AGE -lt 20 ] && (echo "You are not allowed to see secret"; exit 1) || echo "Welcome master"

# echo "Secret is: There is no spoon!"

# When you provide more commands after &&, you need to use () but that creates a problem. The comands inside brackets
# are run in a subshell that gives an exit code at the end. This gives the output:

# ❯ ./22-secret.sh
# Your age:19
# You are not allowed to see secret
# Welcome master
# Secret is: There is no spoon!


# To solve this problem, we need to use curly brackets with a space at the beggining and ; at the end

echo -n Your age: 
read AGE

[ $AGE -lt 20 ] && { echo "You are not allowed to see secret"; exit 1;} || echo "Welcome master"

echo "Secret is: There is no spoon!"