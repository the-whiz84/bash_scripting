Functions

# lines of code which can be called multiple times within a script
# Functions can be created in 2 ways

function_name () {
    <commands>
}

function function_name {
    <commands>
}

# Examples
function hello {
    echo Hello
}
echo "Output from function 'hello': "
hello

# Functions can only be called if the declaration of function was placed before the calling
function hello {
    echo hello $1
}
echo "Output from function hello: "
hello Richard

# We can exit from function using written keyword (return). This will only exit from function, not entire script.
function hello{
    echo hello $1
    return 11
}

echo "Output from function hello: "
hello Richard
echo "return value from function hello is: $?"

# In functions we can declare local variables, that are visible only within the function
function hello {                                                function hello{
    name=$1                                                         local name=$1
    echo "hello $name"                                              echo "hello $name"
}                                                               }
echo "enter your name: "                                        echo "enter your name: "
read name       #Richard                                        read name       #Richard
hello Peter     #hello Peter                                    hello Peter     #hello Peter
echo $name      #Peter                                          echo $name      #Richard

