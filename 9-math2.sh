#!/bin/bash

echo -n "Enter first number: "
read FIRST
echo -n "Enter second number: "
read SECOND

# Do some let here
let RESULT=FIRST+SECOND
echo "$FIRST + $SECOND = $RESULT"

# Do some bc
RESULT=`echo "$FIRST^$SECOND" | bc`
echo "$FIRST ^ $SECOND = $RESULT"
