 #!/bin/bash

# This script can create new user accounts when ran with sudo permissions.
# It uses the first argument provided as the login and all other arguments as the COMMENT section.
# It automatically generates a password for the new account and informs the user if account creation not succesful.
# It displays the username, password and hostname for the created account.

# Make sure the script is run with sudo privileges.
if [[ "${UID}" -ne 0 ]]
then
  echo "You must run this script with sudo privileges." >&2
  exit 1
fi

# If the user doesn't supply at least one argument, give them a hint.
PARAMETERS="${#}"
if [[ ${PARAMETERS} -lt 1 ]]
then
  echo "You must provide at least the username as an argument. You can also provide the full name after username for account comment field." >&2
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
useradd -c "${COMMENT}" -m "${USERNAME}" &> /dev/null

# Check to see if the useradd command succeeded.
if [[ ${?} -ne 0 ]]
then
  echo "Account ${USERNAME} could not be created." >&2
  exit 1
fi

# Set the password.
echo ${PASSWORD} | passwd --stdin ${USERNAME} &> /dev/null

# Check to see if the passwd command succeeded.
if [[ ${?} -ne 0 ]]
then
  echo "Password not created. Please contact admin." >&2
  exit 1
fi

# Force password change on first login.
passwd -e ${USERNAME} &> /dev/null

# Display the username, password and hostname for the created account.
echo "New account created with login:"
echo ${USERNAME}
echo "Initial password is:"
echo ${PASSWORD}
echo "Hostname is:"
echo ${HOSTNAME}
exit 0
