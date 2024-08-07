Math Calculation in bash

let
(())
[]
expr
bc     #Operates floating point

1. Let

#!/bin/bash
NUMBER=7
let RESULT=NUMBER+5   
# no spaces and no $

- Increment operation:
let NUMBER++  (let NUMBER+=5)
- Decrement operation:
let NUMBER--  (let NUMBER-=5)

2. Parentheses (())

RESULT=$(( NUMBER + 5 ))
# spaces are important

3. Brackets []

RESULT=$[ NUMBER + 5 ]

4. Using expr

RESULT=$(expr $NUMBER + 5)
RESULT=`expr $NUMBER + 5`
# When using expression, we need spaces around math operand

5. Floating point operations with bc

RESULT=`echo "$NUMBER * 1.9" | bc`

# we need to first print expression inside " and then pipe it to bc
