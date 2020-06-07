#!/bin/bash

# This script is used to start the django server 

# If any command returns a non-zero(error) status, then it could be caught and the script execution can be terminated immediately
set -e

# used to catch errors
trap 'catcherror $? $LINENO' ERR

# The below function acts like a catch block used in exception handling(observed in different programming languages). It will print the error code and the line number on which the error was generated. The script will be exited later
catcherror()
{
  echo "Error code $1 generated on Line $2"
  exit 1
}

pwd
 
ls

python3 /app/django_project/manage.py runserver 0:8080


