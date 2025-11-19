 #!/bin/bash

# This script can create new user accounts when ran with sudo permissions.
# It uses the first argument provided as the login and all other arguments as the COMMENT section.
# It automatically generates a password for the new account and informs the user if account creation not succesful.
# It displays the username, password and hostname for the created account.

# Make sure the script is run with sudo privileges.
if [[ "${UID}" -ne 0 ]]
then
  echo "You must run this script with sudo privileges."
  exit 1
fi

# If the user doesn't supply at least one argument, give them a hint.
PARAMETERS="${#}"
if [[ ${PARAMETERS} -lt 1 ]]
then
  echo "You must provide at least the username as an argument. You can also provide the full name after username for account comment field."
  exit 1
fi

# The first parameter is the username.
USERNAME="${1}"

# The rest of the parameters are for account comments.
#COMMENT="${2}${3}"
shift
COMMENT="${@}"

# Generate a password.
PASSWORD=$(date +%s%N | sha256sum | head -c8) 

# Create the user with the argument provided.
useradd -c "${COMMENT}" -m "${USERNAME}"

# Check to see if the useradd command succeeded.
if [[ ${?} -eq 0 ]]
then
  echo "Account ${USERNAME} was succesfully created."
else
  echo "Account ${USERNAME} could not be created."
  exit 1
fi

# Set the password.
echo ${PASSWORD} | passwd --stdin ${USERNAME}

# Check to see if the passwd command succeeded.
if [[ ${?} -eq 0 ]]
then
  echo "Initial password is ${PASSWORD}"
else
  echo "Password not created. Please contact admin."
  exit 1
fi

# Force password change on first login.
passwd -e ${USERNAME}

# Display the username, password and hostname for the created account.
echo "New account created with login ${USERNAME}"
echo
echo "Initial password is ${PASSWORD}"
echo
echo "Hostname is ${HOSTNAME}"

exit 0
