Using && and || to shorten IF statements

# Normal if statements
if [ -f hello.txt ]; then
  echo Exists
else
  echo Does not exist
fi

# Shorten IF statement
[ -f hello.txt ] && echo "Exists" - check if true and do what comes after &&

[ -f hello.txt ] || echo "Does not exist"  - check if not true and do what comes after ||

# You can combine everything in one line

[ -f hello.txt ] && echo "Exists" || echo "Does not exist"

# exit status 0 -> && what comes after is run
# exit status not 0 -> || what comes after is run

# Exit status non 0 can come from && statement
# Example
[ -f hello.txt ] && ping 128.0.0.1 || echo "Does not exists"
PING 128.0.0.1  x bytes of data
1 packets transmitted, 0 received, 100% packet loss, time 0ms

Does not exists

# in the above case, the files does exist and returns 0, then %% runs and returns 1, so || also runs and gives output
