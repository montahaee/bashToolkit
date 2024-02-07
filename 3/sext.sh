#!/bin/bash

# Initialize variables
directory="."
maxdepth=""

# Check if the first argument is a directory
if [ -d "$1" ]; then
  # Set the directory to the first argument
  directory="$1"
  # Shift the positional parameters by one
  shift
fi

# Parse the options and their arguments
while getopts "a:p:" opt; do
  case $opt in
    a) # Option -a requires an argument
      current=${OPTARG%,*} # Get the current extension before the comma
      desired=${OPTARG#*,} # Get the desired extension after the comma
      ;;
    p) # Option -p requires an argument
      current=${OPTARG%,*} # Get the current extension before the comma
      desired=${OPTARG#*,} # Get the desired extension after the comma
      maxdepth=1 # Change parent directory
      ;;
    *) # Invalid option
      echo "Usage: rename_extension.sh [directory] -a|-p current,desired"
      exit 1
      ;;
  esac
done

# Invalid extension
if [ -z "$current" ]; then
  echo "Error: You've entered an empty extension for current files."
  exit 1
fi

if [ -z "$desired" ]; then
  echo "Error: You've entered an empty extension for desired files."
  exit 1
fi

# Check if maxdepth is empty or an integer
if [ -z "$maxdepth" ]; then
  # Find and rename files in all directories
  find "$directory" -type f -name "*.$current" -exec bash -c 'mv "$1" "${1%.$2}.$3"' _ {} $current $desired \;
elif [ "$maxdepth" -eq "$maxdepth" ] 2>/dev/null; then
  # Find and rename files in the parent directory
  find "$directory" -maxdepth 1 -type f -name "*.$current" -exec bash -c 'mv "$1" "${1%.$2}.$3"' _ {} $current $desired \;
else
  # Invalid maxdepth value
  echo "Invalid maxdepth value: $maxdepth. Please try again."
  exit 1
fi
