#!/bin/bash 

# This script, when ran with sudo privileges, will allow to create new user accounts on the local machine where it is being run.
# Enforces that it be executed with sudo privileges. If not executed as root, will exit and return an exist status of 1.
# Prompts the person who executes the script to enter the username, full name and initial password for the new acount.
# Creates a new user on the local system with the input provided by the user.
# Informs the user if the account was not able to be created for some reason. If the account is not created, the script gives exit status 1.
# Displays the username, password and host where the account was created.

# Make sure the script is being executed with root privileges.
if [[ "${UID}" -ne 0 ]]
then
 echo 'You must run this script with sudo priviliges'
 exit 1
fi

# Get the username (login).
read -p 'Enter the username for the new account: ' USERNAME

# Get the real name (contents of the description field).
read -p 'Enter the full name of the person that will use this account: ' COMMENT

# Get the password.
read -p 'Enter the initial password for the account: ' PASSWORD

# Create the new account with the username provided.
useradd -c "${COMMENT}" -m ${USERNAME}

# Check to see if the useradd command succeeded.
if [[ ${?} -eq 0 ]]
then
  echo "${USERNAME} account was succesfully created."
else
  echo "${USERNAME} account could not be created."
  exit 1
fi

# Set the password.
echo "${PASSWORD}" | passwd --stdin ${USERNAME}

# Check to see if the passwd command succeeded.
if [[ ${?} -eq 0 ]]
then
  echo "Initial password set to ${PASSWORD}"
else
  echo 'Password was not set correctly, please check password requirements and try again.'
  exit 1
fi

# Force password change on first login.
passwd -e ${USERNAME}

# Display the username, password and the hostname where the user was created.
echo "Account was created with username ${USERNAME}"
echo "Initial password was set to ${PASSWORD}"
echo "Host is: ${HOSTNAME}"

exit 0 
