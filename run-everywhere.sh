#!/bin/bash

# This script pings a list of servers and reports their status. Then it executes the commands given as the user executing the script.
# Uses "ssh -o ConnectTimeout=2" to connect to a host. This way, if a host id down the script doesn't hang for more than 2 seconds per down server.

# Allows the user to specify the following options:
# -f File This allows the user to override the default 'servers' file given and user their own list of servers file.
# -n This allows the user to perform a "dry run" where the commands will be displayed instead of executed. Precede each command that would have been executed
#with "DRY RUN:"
# -s Run the command with sudo privileges on the remote servers.
# -v Enable  verbose mode, which displays the name of the server for which the command is being executed on.

# Enforces that it be executed WITHOUT sudo privileges. If the user wants the remote commands to be executed with sudo, they need to specify the -s option.
# Provides an usage statement if the user does not supply a command to run and returns an exit status of 1.
# Informs the user if the command was not able to be executed succesfully on a remote host.
# Exits with an exit status of 0 or the most recent non-zero exit status of the ssh command.

SERVER_LIST='/home/wizard/Documents/bash_scripting/servers'
SSH_OPTIONS=' -o ConnectTimeout=5'

# Display the usage and exit.
usage() {
  echo "Usage: ${0} [-nsv] [-f FILE] COMMAND" >&2
  echo "Executes COMMAND as a single command on every server." >&2
  echo "-f FILE Use FILE for the list of servers. Default: /home/wizard/Documents/servers" >&2
  echo "-n Dry run mode. Display the COMMAND that would have been executed and exit." >&2
  echo "-s Execute the COMMAND using sudo on the remote server." >&2
  echo "-v Verbose mode. Displays the server name before executing COMMAND." >&2
  exit 1
}


# Make sure the script is not being executed with sudo.
if [[ ${UID} -eq 0 ]]
then
  echo "Do not execute this script with sudo, use the -s option instead."  >&2
  usage
  exit 1
fi

# Parse the options.
while getopts f:nsv OPTION
do
  case "${OPTION}" in
    f) SERVER_LIST="${OPTARG}" ;;
    n) DRY_RUN='true' ;;
    s) SUDO='sudo' ;;
    v) VERBOSE='true' ;;
    ?) usage ;;
  esac
done

# Remove the options while leaving the remaining arguments.
shift "$(( OPTIND - 1 ))"

# If the user doesn't supply at least one argument, give them help.
if [[ "${#}" -lt 1 ]]
then
  echo "You must provide at least one COMMAND to pass to the remote hosts." >&2
  usage
fi

# Anything that remains on the command line is to be treated as a single command.

COMMAND="${@}"

# Make sure the SERVER_LIST file exists.

if [[ ! -e "${SERVER_LIST}" ]]
  then
  echo "Cannot open file: ${SERVER_LIST}" >&2
  exit 1
fi

# Expect the best, prepare for the worst.
EXIT_STATUS='0'

# Loop through the SERVER_LIST
for SERVER in $(cat ${SERVER_LIST})
do
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${SERVER}"
  fi

  SSH_COMMAND="ssh ${SSH_OPTIONS} ${SERVER} ${SUDO} ${COMMAND}"

# If it's a dry run, dont execute anything, just echo it.
  if [[ "${DRY_RUN}" = 'true' ]]
  then
    echo "DRY RUN: ${SSH_COMMAND}"
  else
    ${SSH_COMMAND}
    SSH_EXIT_STATUS="${?}"

# Capture any non-zero exit status from the ssh command and report to the user.
    if [[ "${SSH_EXIT_STATUS}" -ne 0 ]]
    then
      EXIT_STATUS="${SSH_EXIT_STATUS}"
      echo "Execution on ${SERVER} failed." >&2
    fi
  fi
done

exit ${EXIT_STATUS}
