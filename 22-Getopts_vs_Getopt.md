Manual parsing vs Getopts vs Getopt

./script.sh -a -b
hello
hi

./script.sh -ab # user would expect to work the same as above so we need to parse the parameters
hello
hi

-ab -> -a -b

# For such cases we can use tools getopts or getopt

1. Getopts

#!/bin/bash

while getopts a:b:cd param; do
    case $param in
        a ) echo " "
            echo "parameter 'a' with argument: $OPTARG"
            ;;
        b ) echo "parameter 'b' with argument: $OPTARG"
            ;;
        c ) echo "parameter 'c' selected (no colon, no argument)"
            ;;
        d ) echo "parameter 'd' selected (no colon, no argument)"
            ;;
    esac
done

# Example
./getopts.sh -a "hello buddy" -cd -b car

parameter 'a' with argument: hello buddy
parameter 'c' selected (no :, no argument)
parameter 'd' selected (no :, no argument)
parameter 'b' with argument: car

# Getopts works with a variable called OPTIND
# OPTIND is initialized to 1 each time the shell or a shell script is invoked. Getopts places index of the next argument to be processed into the variable OPTIND.


2. Getopt

# is a more advanced version of getopts
# parse command options (enhanced)

opts=`getopt -o a::b:cde --long file::,name:,help -- "$0"`
eval set -- "$opts"

# long parameters are divided by , (comma)
# at the end of the command we specify all arguments using "-- "
# :: means the argument is followed by an optional parameter, we can provide it or not
# This is tricky to write as we have to provide the parameter after short argument without space and after long argurment after = sign
./script.sh -aoptionalparameter
./script.sh --file=optionalparameter 

# EXAMPLE
#!/bin/bash

echo "All arguments: $@"
opts=`getopts -o a::b:cde --long file::,name:,help -- "$@"`
eval set -- "$opts"
echo "All arguments after getopt: $@"


./getopt.sh -cde -athis-is-optional -b required --file=optional --name required --help
All arguments: -cde -athis-is-optional -b required --file=optional --name required --help
All arguments after getopt: -c -d -e -a this-is-optional -b required --file optional --name required --help -- 
