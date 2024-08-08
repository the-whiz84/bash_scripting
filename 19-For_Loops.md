
For Loops

# A loop is a block of code that iterates a list of commands as long as the loop control condition is true.

for arg in [list]
do
  command(s)..
done

# e.g.
for PLANET in Mercury Venus Earth
do
  echo $PLANET
done

#Mercury
#Venus
#Earth

# Since IFS is by default a space (IFS=$' \t\n'), for loops work with variables that contains multi word strings
PLANETS="Mercury Venus Earth"

for PLANET in $PLANETS
do
  echo $PLANET
done

#Mercury
#Venus
#Earth

# We can also use Wildcards in FOR loops

for FILE in *.txt
do
  echo $FILE
done

#hello.txt
#work.txt
#something.txt ....

for NUMBER in {1..10}
do
  echo $NUMBER
done

#1
#2
...
#10

# Most often FOR Loops are used to iterate through all arguments provided

for ARG in "$@"
do
  echo $ARG
done

# Why we use $@ instead of $#
"$@" - all arguments, expands as "$1" "$2" "$3" ..
"$#" - all arguments, expands as one string "$1c$2c$3", where c is the first character of IFS (usually space)

# For Loops can be used using C style
for ((i=1; i <= 10; i++))
do
  echo $i
done

#1
#2
...
#10