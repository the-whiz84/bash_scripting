AWK

# searches files for lines that contain certain patterns
# performs operation described in AWK body on line with certain pattern
# performs operation described in AWK body on chosen line

1. Basic Structure

awk 'program_you_will_write' input-file1 input-file2...

# is divided in 3 sections
awk 'BEGIN{
    code_in_BEGIN_section
}

{code_in_main_body_section}

END{
    code_in_END_section}'input-file1 input file-2...

# Example
echo "one two three four" | awk 'BEGIN{code_in_BEGIN_section}{code_in_main_body_section}END{code_in_END_section}'

# we can omit specific sections
echo "one two three four" | awk '{code_in_main_body_section}'

2. AWK commands
# in AWK body bash features do not work
# Completely new language in AWK body:
- print         #replaces echo
- if-else       |
- for loop      |all have different structures
- many more     |

# New features we can call on specific line of text
- NF (number of fields)
- NR (number of records)
- RS (record separator)
- $1, $2,.. (specific fields)
- ...others


3. print, BEGIN{},{}, END{}

# Begin section
awk 'BEGIN{print "Hello"}'
Hello

# Main Body
awk '{print "Hello"}'  # will process every line provided
Hello

Hello

Hello

Hello

# End section - only occurs when all lines have been processed
awk 'END{print "Hello"}'



(nothing is returned)

# More examples
echo "one two three four" | awk '{print "Hello"}'
Hello   #only one line found so only 1 Hello printed

awk 'BEGIN{print "BEGIN part"} {print "Hello"}' hello.txt
BEGIN part
Hello
Hello
Hello

awk 'BEGIN{print "BEGIN part"} {print "Hello"} END{print "END part}' hello.txt
BEGIN part
Hello
Hello
Hello
END part


4. Fields

echo "one two three four" | awk '{print $0}'
one two three four

# $0 represents all fields in the awk command
# fields are by default separated by space

echo "one two three four" | awk '{print $1}'
one

echo "one two three four" | awk '{print $3}'
three

# Create a file named table in Test_Files
cat ./Test_Files/table
name    age     Unit
Peter   50      IT
Jane    30      HR
John    25      IT
Andreas 45      HR

awk '{print $1}' ./Test_Files/table
name
Peter
Jane
John
Andreas

cat table | awk '{print $1 " " $3}'
name Unit
Peter IT
Jane HR
John IT
Andreas HR

# we can also add space using comma
cat table | awk '{print $1 " ", $3, " hello"}'
name  Unit  hello
Peter  IT  hello
Jane  HR  hello
John  IT  hello
Andreas  HR  hello


5. Search patterns

cat ./Test_Files/table
name    age     Unit
Peter   50      IT
Jane    30      HR
John    25      IT
Andreas 45      HR

cat table | awk '/Peter/ {print $1 " " $3}'
Peter IT

cat table | awk '/IT/ {print $1 " " $3}'
name Unit
Peter IT
John IT

# to suppress header, we add tab to search pattern
cat table | awk '/\tIT/ {print $1 " " $3}'
Peter IT
John IT

# AWK by default uses regular expressions, so special characters need to be used with \
'?', '+', '{', '|', '(' and ')' lose their special meaning so we transform them to
'\?', '\+', '\{', '\|', '\(' and '\)'

# To print all records without header, we use exclamation mark ! before searching pattern
cat table | awk '!/name/ {print $0}'
Peter   50      IT
Jane    30      HR
John    25      IT
Andreas 45      HR

# We can pipe awk into another awk for multiple search patterns
cat table | awk '!/^name/ {print $0}' | awk '/IT/ {print $0}'
Peter   50      IT
John    25      IT

# Another way to search for a specific line
cat table | awk '$1 == "Peter"'
Peter   50      IT

cat table | awk '$1 != "name"'
Peter   50      IT
Jane    30      HR
John    25      IT
Andreas 45      HR


6. NF - number of fields

echo "one two three four" | awk '{print NF}'
4

# Since $ is used in AWK to display fields, we get this
echo "one two three four" | awk '{print $NF}'
four

echo "one two three four" | awk '{print $(NF-1)}'
three

echo "one two three four" | awk '{print $(NF-2)}'
two

cat ./Test_Files/table
name    age     Unit
Peter   50      IT
Jane    30      HR
John    25      IT
Andreas 45      HR

cat table | awk '{print NF}'
3
3
3
3
3

cat table | awk '{print "Number of fields in this line: " NF}'
Number of fields in this line: 3
Number of fields in this line: 3
Number of fields in this line: 3
Number of fields in this line: 3
Number of fields in this line: 3


7. NR - number of records

echo "one two three four" | awk '{print NR}'
1
# result is 1 as we have one record, each record is separated by a line

cat ./Test_Files/table
name    age     Unit
Peter   50      IT
Jane    30      HR
John    25      IT
Andreas 45      HR

# NR processes line by line
cat table | awk '{print NR}'
1
2
3
4
5

# to get the total number of records we use the END section
cat table | awk 'END{print NR}'
5


8. FS - field separator

# in AWK fields are separated by default by space
# we can change that using FS
echo "one two three four" | awk 'BEGIN{FS="two"} {print $1 " " $2}'
one   three four

cat /etc/passwd | awk 'BEGIN{FS=":"} {print $1 " " $7}'
nobody /usr/bin/false
root /bin/sh
daemon /usr/bin/false

# Since FS is one of the most used options in AWK, we can shorten it to argument -F
cat /etc/passwd | awk -F ":" '{print $1,$3}'
nobody -2
root 0
daemon 1


9. RS - record separator

# in AWK records are separated by a line by default

cat /etc/passwd | awk 'BEGIN{RS=":"} {print $0}'
nobody
*
-2
-2
Unprivileged User
/var/empty
/usr/bin/false
root
*
0
0
System Administrator
/var/root
/bin/sh
daemon

cat /etc/passwd | awk 'BEGIN{RS=":"}  END{print NR}'
733
cat /etc/passwd | wc -l
132

cat /etc/passwd | awk 'BEGIN{RS="\n"}  END{print NR}'
132


10. AWK -variable assignment

# Assignment:
- a=1
- RS="\n"
- FS=":"

# Math operations
- a++   (a--)
- a=a+1 (a=a-1)

# Classical math operations:
a=b+c
a=b*c
a=b/c
a=b-c

# Other operations available in AWK
var += increment        #Add increment to the value of var.
var -= decrement        # Substract decrement from the value of var.
var *=coefficient       # Multiply the value of var by coefficient.
var /=divisor           # Divide the value of var by divisor.
var %=modulus           # Set var to its remainder by modulus.
var ^=power-number      # Raise var to the power power-number.
var **=power-number     # Raise var to the power power-number.

# Examples:
awk 'BEGIN{print 1+1}'
2

awk 'BEGIN{print 6-1}'
5

awk 'BEGIN{print 6/3}'
2

awk 'BEGIN{print 6/3.5}'
1.71429

cat /etc/passwd | awk 'BEGIN{RS="\n"} END{print NR}'
41

cat /etc/passwd | awk 'BEGIN{RS="\n"; count=0} {count++} END{print NR, count}' 
41 41

cat /etc/passwd | awk 'BEGIN{RS="\n"; count=0} {count+=2} END{print NR, count}'
41 82


11. IF statements

if (condition) {
    command(s)
}
else {
    command(s)
}

# Comparison in AWK:
var == 5, var== "hello"
var > 5, var >= 5
var < 5, var <= 5
var != 5, var != "hello"

# Examples
cat ./Test_Files/table
name    age     Unit
Peter   50      IT
Jane    30      HR
John    25      IT
Andreas 45      HR

cat table | awk '{if ($1 == "Jane") print $0}'
Jane    30      HR

cat /etc/passwd | awk -F ":" '{if ($1 == "root") {print $1, $7}}'
root /bin/sh

cat /etc/passwd | awk -F ":" '{if ($1 == "root") {print $1, $7} else {print $1}}'
nobody
root /bin/sh
daemon


12. FOR Loop

for (initialization; condition; increment) {
    command(s)
}

awk 'BEGIN{for (i-1;i<=10;i++) {print "hello", i}}'

# Examples
cat ./Test_Files/table
name    age     Unit
Peter   50      IT
Jane    30      HR
John    25      IT
Andreas 45      HR

cat table | awk '{for (i=1;i<=NF;i++) {print "field:",i,$i}}'
field: 1 name
field: 2 age
field: 3 Unit
field: 1 Peter
field: 2 50
field: 3 IT
field: 1 Jane
field: 2 30
field: 3 HR
field: 1 John
field: 2 25
field: 3 IT
field: 1 Andreas
field: 2 45
field: 3 HR


# Print only files in /etc/ that end with .conf extension
ls -l /etc/ | awk '/^-/' | awk '/\.conf$/'

-rw-r--r--   1 root  wheel    1051 Aug  4 13:31 asl.conf
-rw-r--r--   1 root  wheel    1935 Aug  4 13:31 autofs.conf
-rw-r--r--   1 root  wheel       0 Aug  4 13:31 kern_loader.conf
-r--r--r--   1 root  wheel    2451 Aug  4 13:31 man.conf
-rw-r--r--   1 root  wheel    1318 Aug  4 13:31 newsyslog.conf
-rw-r--r--   1 root  wheel      43 Aug  4 13:31 nfs.conf
-rw-r--r--   1 root  wheel     557 Aug  4 13:31 notify.conf
-rw-r--r--@  1 root  wheel      27 Aug  1 13:16 ntp.conf
-rw-r--r--   1 root  wheel      23 Aug  4 13:31 ntp_opendirectory.conf
-rw-r--r--   1 root  wheel    1027 Aug  4 13:31 pf.conf
-rw-r--r--   1 root  wheel     891 Aug  4 13:31 rtadvd.conf
-rw-r--r--   1 root  wheel      96 Aug  4 13:31 syslog.conf


# Count file size in a specific folder
ls -l /etc/ | awk '{sum+=$5} END{print "Size: ", sum, "B"}'
Size:  811018 B

ls -l /etc/ | awk '{sum+=$5} END{print "Size: ", sum/1024, "KB"}'
Size:  792.01 KB

ls -l /etc/ | awk '{sum+=$5} END{print "Size: ", sum/1024/1024, "MB"}'
Size:  0.773447 MB