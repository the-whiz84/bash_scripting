Arrays

1. Declaration
ARRAY=(value1 value2 ...valueN)

# Example
ARRAY=(one, two, three)

2. Calling
${ARRAY[0]}     #one
${ARRAY[1]}     #two
${ARRAY[2]}     #three

# first index is always 0

3. Other options to call a value from Array

${ARRAY[@]}     #all items in array
${ARRAY[*]}     # all items in array, delimited by first character of IFS (space)
${!ARRAY[@]}    # all indexes in the array (@/*) inside [] we use either @ or *
${#ARRAY[@]}    # number of items in the array (@/*)
${#ARRAY[0]}    # length of item zero
