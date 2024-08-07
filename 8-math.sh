#!/bin/bash

NUMBER=5

# Calculate number +5 using all methods

# Using let
let RESULT=NUMBER+5
echo Result from let: $RESULT

# Using (())
RESULT=$(( NUMBER + 5 ))
echo "Result from (()): $RESULT"

# Using []
RESULT=$[ NUMBER + 5 ]
echo "Result from []: $RESULT"

# Using expr
RESULT=$(expr $NUMBER + 5)
echo "Result from expr: $RESULT"

# Using bc. MUltiplt number by 1.9

RESULT=`echo "$NUMBER * 1.9" | bc`
echo "Result from bc: $RESULT"
