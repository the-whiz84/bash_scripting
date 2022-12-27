#!/bin/bash

# This script allows the user to delete an account by providing username.
# Optionally, they can also provide arguments to remove the files or backup the user's home directory.
# It helps the user with usage statements when an invalid argument is provided.

# By default the script will disable the account but will accept following options:
# -d Deletes accounts instead of disabling them;
# -r Removes the home directory associated with the account(s);
# -a Creates an archive of the home directory associated with the account(s).


ARCHIVE_DIR='/archive'

# Display the usage and exit.
usage() {
  echo "Usage ${0} [-dra] LOGIN [LOGIN] ..." >&2
  echo "Disable user(s) account" >&2
  echo "-d  Deletes the user account instead of disabling it" >&2
  echo "-r  Removes the account's home directory" >&2
  echo "-a  Create an archive of the account's home directory" >&2
  exit 1
}

# Make sure the script is being run with sudo or as root.
if [[ ${UID} -ne 0 ]]
then
  echo 'You must run the script with sudo or as root' >&2
  exit 1
fi

# Parse the options

while getopts dra OPTION
do
  case "${OPTION}" in
    d) DELETE_USER='true' ;;
    r) REMOVE_OPTION='-r' ;;
    a) ARCHIVE='true' ;;
    ?) usage ;;
  esac
done

# Remove the options while leaving the remaining arguments.
shift "$(( OPTIND - 1 ))"

# If the user doesn't supply at least one argument, give them help.

if [[ "${#}" -lt 1 ]]
then
  usage
fi

#Loop through all the usernames supplied as arguments.
for USERNAME in "${@}"
do
  echo "Processing user: ${USERNAME}"

# Make sure the UID of the account is at least 1000.
  USERID=$(id -u ${USERNAME})
  if [[ "${USERID}" -lt 1000 ]]
  then
    echo "You cannot remove the ${USERNAME} as it is a system account." >&2
    exit 1
  fi

# Create an archive if requested to do so.
 if [[ "${ARCHIVE}" = 'true' ]]
  then
# Make sure the ARCHIVE_DIR directory exists.
  if [[ ! -d "${ARCHIVE_DIR}" ]]
  then
    echo "Creating ${ARCHIVE_DIR} directory"
    mkdir -p ${ARCHIVE_DIR}
    if [[ "${?}" -ne 0 ]]
    then
      echo "The archive directory ${ARCHIVE_DIR} could not be created." >&2
      exit 1
    fi
  fi 
# Archive the user's home directory and move it into the ARCHIVE_DIR
  HOME_DIR="/home/${USERNAME}"
  ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
  if [[ -d "${HOME_DIR}" ]]
  then
    echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
    tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
    if [[ "${?}" -ne 0 ]]
    then
      echo "Could not create ${ARCHIVE_FILE}" >&2
      exit 1
    fi
  else
    echo "${HOME_DIR} does not exist or is not a directory." >&2
    exit 1
  fi
 fi

 if [[ "${DELETE_USER}" = 'true' ]]
 then
# Delete the user.
   userdel ${REMOVE_OPTION} ${USERNAME}
# Check to see if the userdel command succeeded.
# We don't want to tell the user that an account was deleted when it has not been.
   if [[ "${?}" -ne 0 ]]
   then
     echo "The account ${USERNAME} was NOT deleted." >&2
     exit 1
   fi
   echo "The account ${USERNAME} was deleted."
 else
   chage -E 0 ${USERNAME}
# Check to see if the chage command succeeded.
# We don't want to the the user that an account was disabled when it has not been.
   if [[ "${?}" -ne 0 ]]
   then
     echo "The account ${USERNAME} was NOT disabled." >&2
     exit 1
   fi
   echo "The account ${USERNAME} was disabled."
 fi

done

exit 0
