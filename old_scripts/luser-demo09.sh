#!/bin/bash

# This script demonstrates the case statements.

# Using if statements like previous scripts.

#if [[ "${1}" = "start" ]]
#then
#  echo 'Starting'
#elif [[ "${1}" = 'stop' ]]
#then
#  echo 'Stopping'
#elif [[ "${1}" = 'status' ]]
#then
#  echo 'Status:'
#else
#  echo 'Supply a valid option.' >&2
#  exit 1
#fi

# Using case statements example.
#case "${1}" in
#  start)
#    echo 'Starting'
#    ;;
#  stop)
#    echo 'Stopping'
#    ;;
#  status|state|--status|--state)
#    echo 'Status'
#    ;;
#  *)
#    echo 'Supply a valid option' >&2
#    exit 1
#    ;;
#esac

case "${1}" in
  start) echo 'Starting' ;;
  stop) echo 'Stopping' ;;
  status) echo 'Status' ;;
  *)
    echo 'Supply a valid option' >&2
    exit 1
    ;;
esac
