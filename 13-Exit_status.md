Exit Status

We can get a return value of a command in following way:

command
echo $?

- $? will give a return value of previous command
- the return value is called 'exit status'
- if the command exits successfully, exit status will be 0, otherwise some non-zero value
- we can exit a script using 'exit' command

Exit status range is 0-255
256 - 0
257 - 1
258 - 2 etc.