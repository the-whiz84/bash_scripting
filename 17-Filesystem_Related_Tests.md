Filesystem Related Tests

# File test operators                               Description, what is returned
[ -e $VAR ]                                 True if variable holds an existing file or directory
[ -f $VAR ]                                 True if variable holds an existing regular file
[ -d $VAR ]                                 True if variable holds an existing directory
[ -x $VAR ]                                 True if variable is an executable file
[ -L $VAR ]                                 True if variable holds the path of a symlink
[ -r $VAR ]                                 True if variable holds file that is readable
[ -w $VAR ]                                 True if variable holds file that is writable


# Example

if [ -f $FILE ]; then
  echo File exists
else
  echo File does not exist
fi
