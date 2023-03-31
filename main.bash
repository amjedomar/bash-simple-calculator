#!/usr/bin/env bash

logs=''

function append_log {
  if [ "$logs" = '' ]; then
    logs="$1"
  else
    logs="$logs\n$1"
  fi
}

function sys_echo {
  append_log "$1"
  echo "$1"
}

function calc {
  re='^-?[0-9]+(\.[0-9]+)? *[+*^/-] *-?[0-9]+(\.[0-9]+)?$'

  if [[ "$1" =~ $re ]]; then
      sys_echo $(bc -l <<< "scale=2; $1")
  else
      sys_echo 'Operation check failed!'
  fi
}

sys_echo "Welcome to the basic calculator!"

while true; do
  sys_echo "Enter an arithmetic operation or type 'quit' to quit:"

  read input
  append_log "$input"

  if [ "$input" = 'quit' ]; then
    break
  else
    calc "$input"
  fi
done

sys_echo 'Goodbye!'

printf "${logs}" > 'operation_history.txt'
