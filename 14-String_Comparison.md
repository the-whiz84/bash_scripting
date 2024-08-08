String Comparison

1. Compare two strings:
[ "$STR1" = "$STR2!" ]

# Don't forget spaces
[_"$STR1"_!=_"$STR2"_]

[ "$STR1" = "hello" ]
[ "STR2" != "hello" ]

If STR1 or STR2 are not defined or empty, we would get error message 'Unary operator expected' when not using "" quotation marks.

# Bash can handle it another way, using [[ ]]
# This is not widely used and most scripts are using quotation marks with single brackets

[[ $STR1 = $STR2 ]]
[[ $STR1 = "hello" ]]

2. Test if string is empty

[ -z "$STR1" ]  returns true if STR1 holds an empty string
[ -n "$STR1" ]  returns true if STR1 holds a non-empty string

3. Alphabetically compare two strings

[[ $STR1 > $STR2 ]]

[[ $STR1 < $STR2 ]]

4. Wildcards and regular expressions

- Wildcards
[[ $STR1 == string-with-wildcards ]]

- Regular expressions
[[ $STR1 =~ $regex ]]
