#!/bin/bash

# Provide one word/sentence as an argument to the script. If in that sentence will be IP address, 
#find out if that IP is reachable or not.

# Argument check
if [ $# -ne 1 ]; then
  echo "Provide exactly one argument e.g. $0 argument"
  exit 1
fi

VAR1=$1

# IP address regex eg 127.0.0.1

REGEX="[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[[:digit:]]{1,3}"

# Since IPs can only be in range 0-255, a better way would be:
#REGEX="[1-255]\.[0-255]\.[0-255]\.[0-255]"

# Regex check
if ! [[ $VAR1 =~ $REGEX ]]; then
  echo "No valid IP address provided"
  exit 2
fi

IP=${BASH_REMATCH[0]}

# Find if IP address is reachable or not
ping -c3 $IP 1>/dev/null

if [ $? -eq 0 ]; then
  STATUS="ALIVE"
else
  STATUS="NOT REACHABLE"
fi

echo "IP found: $IP ($STATUS)"
