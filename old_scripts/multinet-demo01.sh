#!/bin/bash

# This script pings a list of servers and reports their status.

SERVER_FILE='/home/wizard/Documents/bash_scripting/servers'

if [[ ! -e "${SERVER_FILE}" ]]
then
  echo "Cannot open file: ${SERVER_FILE}" >&2
  exit 1
fi

for SERVER in $(cat ${SERVER_FILE})
do
  echo "Pinging ${SERVER}"
  ping -c 3 ${SERVER} &> /dev/null
  if [[ "${?}" -ne 0 ]]
  then
    echo "${SERVER} is not reachable."
  else
   echo "${SERVER} is up."
  fi
done

