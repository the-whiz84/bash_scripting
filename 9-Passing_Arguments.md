Arguments - Accessing them from script

$0 - script name
$1 - first argument
$2 - second argument
..
$n - nth argument

"$@" - all arguments, expands as "$1" "$2" etc

"$*" - all arguments, expands as one string "$1c$2c$3", where c is the first character of IFS (internal field separator, usually space)

$# - arguments count

IFS is used by the shell to separate words. We can get current setting using:
set | grep ^IFS