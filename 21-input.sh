#!/bin/bash

# Read data from users and make them option if provided data is correct.

echo -n "Enter your name: "
read NAME
echo -n "Enter your age: "
read AGE
echo -n "Enter your department: "
read DEP

echo "You have entered following: "
echo "Name: $NAME"
echo "Age: $AGE"
echo "Department: $DEP"

CHECK=0

while [ $CHECK -eq 0 ]
do
    echo -n "Is that correct? [y/n] "
    read ANSWER

    case "$ANSWER" in
    "y"|"Y" )
        echo "Name: $NAME"          >> ./Test_Files/employee.txt
        echo "Age: $AGE"            >> ./Test_Files/employee.txt
        echo "Department: $DEP"     >> ./Test_Files/employee.txt
        echo "=================="   >> ./Test_Files/employee.txt
        echo "Your data was saved into employee file"
        CHECK=1
        ;;
    N|n )
        echo "Nothing was saved, run the script again if you want to update your data into employee file."
        CHECK=1
        ;;
    * )
        echo " Wrong answer(s) provided"
        ;;
    esac
done