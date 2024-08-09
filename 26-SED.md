SED

1. Basics

# SED is a stream editor used to perform basic text transformation on an input stream (from command or file)

sed OPTIONS ...[SCRIPT] [INPUTFILE...]
cat [INPUTFILE...] | sed OPTIONS...[SCRIPT]

SCRIPT
[addr]X[options]
- X is a single-letter sed command
- [addr] can be a single line number, a regular expression or a range of lines. If [addr] is specified, the command X will be executed only on the matched lines
- Additional [options] are used for some sed commands

# By default sed does not modify input files  but prints to the screen the result

# Examples:
sed '30,35d' input.txt > output.txt
- the following example deletes lines 30 to 35 in the input file
- 30,35 is an address range
- d is the delete command


2. SED commands:

- a text                        #append text after a line
- d                             # delete the pattern space
- i text                        # insert text before a line
- p                             # print the pattern space
- q[exit-code]                  # (quit) Exit sed without processing any more commands or input
- s/regexp/replacement/[flags]  # (substitute) Match the regular expression agains the content of the pattern-space. 
                                #If found, replace matched string with replacement.
...


3. Command-line options:

- n             # disable automatic printing; sed only produces output when explicitly told to via the p command.
- e script      # add script
- r             # use extended regular expressions rather than basic regex
...

# By default, basic regex is used by grep, awk and sed. In BASH, extended regex is used.
# In basic regex the meta-characters ? + { | ( and ) lose their special meaning. Instead we use the backslashed versions: \? \+ \{ \| \( \).


3. Print command and -n option

# sed '/Peter/' Test_Files/table2
sed: 1: "/Peter/": command expected

# sed '/Peter/p' Test_Files/table2
name    age     Unit
Peter   50      HR
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR  
# Peter line shows twice because by default sed prints all lines to screen. Since we used command p for print, the line is repeated

# We can suppress this by using option -n

# sed -n '/Peter/p' Test_Files/table2
Peter   50      HR

# sed -n '3p' Test_Files/table2
John    20      IT

# sed -n '2,7p' Test_Files/table2
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR 


4. a - Append and i - prepend commands


# cat Test_Files/table2
name    age     Unit
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR 

# sed '/IT/a contact: tel. 777 111 222' table2
name    age     Unit
Peter   50      HR
John    20      IT
contact: tel. 777 111 222
Joshua  25      IT
contact: tel. 777 111 222
Mark    33      PR
Anthony 21      PR%    
# The text was added after the matching lines

# sed '/IT/i contact: tel. 777 111 222' table2
name    age     Unit
Peter   50      HR
contact: tel. 777 111 222
John    20      IT
contact: tel. 777 111 222
Joshua  25      IT
Mark    33      PR
Anthony 21      PR%   
# By using command i the text was added before each line matching.

# sed '1i Employee List' table2
Employee List
name    age     Unit
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR%  


5. d - Delete command

# cat Test_Files/table2
name    age     Unit
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR 

# sed '/IT/d' table2
name    age     Unit
Peter   50      HR
Mark    33      PR
Anthony 21      PR
# cat table2
name    age     Unit
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR 
# The file remains the same as the output was only printed to terminal.

# If we change column name from Unit to UNIT, we see the following
# sed '/IT/d' table2
Peter   50      HR
Mark    33      PR
Anthony 21      PR

# sed '/\tIT/d' table2
name    age     UNIT
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR
# Does not work on MacOS

# sed '/[[:space:]]IT/d' table2
name    age     UNIT
Peter   50      HR
Mark    33      PR
Anthony 21      PR


6. c - Change command

# cat Test_Files/table2
name    age     Unit
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR 

# sed '/PR/c Hidden information from PR unit' table2
name    age     UNIT
Peter   50      HR
John    20      IT
Joshua  25      IT
Hidden information from PR unit
Hidden information from PR unit

# sed '/HR/c Hidden information from HR unit' table2
name    age     UNIT
Hidden information from HR unit
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR


7. q - Quit Command

# cat Test_Files/table2
name    age     Unit
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR 

# sed '/Mark/q2' table2 
name    age     UNIT
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
# echo $?
2
# We wanted to exist with exist status 2 when Mark line was found

# sed '/Richard/q2' table2
 name    age     Unit
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR 
# echo $?
0
# Since Richard does not exist in table, all lines are printed and exit status is 0

# Sometimes we want to exist with an exist status when pattern is found and not print anything, so we use option -n
# sed -n '/Mark/q2' table2 

# echo $?
2

# If we want to exist with status code and at the same time print the line with -p, we receive an error
# sed -n '/Mark/pq2' table2 
sed: -e expression #1, char 8: extra characters after command

# By default, sed accepts only one command at a time but there is a workaround.


8. e - Run multiple sed commands

# cat Test_Files/table2
name    age     Unit
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR 

# sed -n '/Mark/pq2' table2 
sed: -e expression #1, char 8: extra characters after command

# sed -ne '/Mark/p' -ne '/Mark/q2' table2 
Mark    33      PR
# echo $?
2

# sed -e '/Mark/a after Mark' -e '/Mark/i before Mark' table2
name    age     UNIT
Peter   50      HR
John    20      IT
Joshua  25      IT
before Mark
Mark    33      PR
after Mark
Anthony 21      PR


9. i - Changing files

# sed -ni '/Peter/p' table3

# cat table3
Peter   50      HR
# We see no output on the cli but the file was replaced with the line matching pattern

# sed -i '/Peter/a after Peter' table3

# cat table3
name    age     UNIT
Peter   50      HR
after Peter
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR


10. e - Perform shell commands

# cat Test_Files/table2
name    age     Unit
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR 

# sed '/name/e echo "Date: "; date' table2
Date: 
Fri Aug  9 20:51:11 EEST 2024
name    age     UNIT
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR

# sed '/name/e echo "Date: "; date; echo "Output of pwd:"; pwd' table2
Date: 
Fri Aug  9 20:53:04 EEST 2024
Output of pwd:
/Users/wizard/Developer/bash_scripting/Test_Files
name    age     UNIT
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR

# sed '1e date' table2
Fri Aug  9 20:56:09 EEST 2024
name    age     UNIT
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR


11. s - Substitute command

# The most used sed commands
- s/regexp/replacement/[flags]  # (substitute) Match the regular expression agains the content of the pattern-space. 
                                #If found, replace matched string with replacement.

# echo "one two three four" | sed 's/three/five/'
one two five four

# echo "Hana is 50 years old" | sed 's/[[:digit:]]\+/***/'
Hana is *** years old

- g flag -- globally

# echo "0 2 9 0 5" | sed 's/0/1/'
1 2 9 0 5
# echo "0 2 9 0 5" | sed 's/0/1/g'
1 2 9 1 5
# By default, substitute only performs the command on first match, we need to use flag -g for all matches

# Examples:

# cat table2
name    age     UNIT
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR

# sed 's/John/Wizard/' table2
name    age     UNIT
Peter   50      HR
Wizard    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR

# sed '2s/John/Wizard/' table2
name    age     UNIT
Peter   50      HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR
# there is no change as 2nd line does not match pattern

# sed '1,$s/John/Richard/' table2
name    age     UNIT
Peter   50      HR
Richard    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR

# sed -i '1,$s/John/Richard/' table4

# at table4
name    age     UNIT
Peter   50      HR
Richard    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR

# Hide age in table of people over 30
# sed 's/[3-9][[:digit:]]/**/' table2
name    age     UNIT
Peter   **      HR
John    20      IT
Joshua  25      IT
Mark    **      PR
Anthony 21      PR

# sed 's/HR/& & &/' table2
name    age     UNIT
Peter   50      HR HR HR
John    20      IT
Joshua  25      IT
Mark    33      PR
Anthony 21      PR
