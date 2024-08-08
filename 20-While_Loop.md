While Loop

while [ condition ]
do
  command(s)
done

# While loop is usually used when the number of repetitions is not known
# While loop will run as long as exit code of condition is true

while [ "$NAME" != "stop" ]
do
  echo -n Enter your name:
  read NAME
done

# C-style While Loop
while (( condition ))
do
  command(s)
done

A=1
LIMIT=10

while (( A < LIMIT ))
do
  touch $A
  let A++
done
# we cannot use $ inside (( )) in this style


# Reading files with While Loop

while read line        #we read one line from the file
do
  command(s)           # we give commands to do something with that line
done < "$FILENAME"     # after done we need to specify the source file

# Another method to supply the file
cat "$FILENAME" |
while read line
do
  command(s)
done
