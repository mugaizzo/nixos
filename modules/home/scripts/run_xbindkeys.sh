#!/bin/bash

# Name of the process to run and monitor
PROCESS_NAME="xbindkeys"

# Find all existing instances of the process
PIDS=$(pidof "$PROCESS_NAME")

# Kill all existing instances
if [ -n "$PIDS" ]; then
  kill -9 $(echo "$PIDS" | tr ' ' '\n' | xargs)
fi

# Run the process in the background
"$PROCESS_NAME" &