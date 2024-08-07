Regular Expressions

# Symbol        Description                     Example               Example matches
    .       Any single character                 bo.k                   book, bo1k...
    *       Preceding item must match            co*l                   cl, c0l, cool, coool ...
            zero or more times
    ^       Start if the line marker            ^hello                  line starting with "hello"
    $       End of the line marker              hello$                  line ending with "hello"
    []      Any one of characters enclosed      coo[kl]                 cook or cool
    [-]     Any character within the range      file[1-3]               file1, file2, files3
    [^]     Any character except those          file[^012345]           file6, file7, file8, file9
            enclosed in brackets
    ?       Preceding item must match           colou?r                 color, colour (NOT colouur)
            one or zero times
    +       Preceding item must match one       file1+                  file1, file11, file111
            or more times
    {n}     Preceding item must match n times   [0-9]{3}                Any 3 digit number: 111, 097, 256, 787
    {n, }   Minimum number of times the         [0-9]{3, }              Any 3 or more digit number: 111, 1256, 145895...
            preceding item should match
    {n,m}   Minimum and maximum number of       [0-9]{1,3}              1, 158, 26....NOT 1256, 11111...
            times the preceding item must match
    \       Escape character - escape any       hell\.o                 hell.o
            special character, ignore meaning                           NOT hello, hell1o...

# Regex in Bash
[[ $STRING =~ $REGEX ]]

REGEX="http://.*\.jpg"

${BASH_REMATCH[0]}   - part of the STRING which match REGEX (e.g. http://images.jpg)

${BASH_REMATCH[1]}   - part of the REGEX which is enclosed in first parentheses
                    e.g. REGEX="http://(.*)\.jpg - which would represent as "images"
                    