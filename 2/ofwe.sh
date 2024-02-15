#!/bin/bash

# Initialize variables
directory="."
maxdepth=""
current=""

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
      ;;
    p) # Option -p requires an argument
      current=${OPTARG%,*} # Get the current extension before the comma
      maxdepth=1 # Change parent directory
      ;;
    *) # Invalid option
      echo "Usage: open_extension.sh [directory] -a|-p desired_extension to open"
      exit 1
      ;;
  esac
done

# Invalid extension
if [ -z "$current" ]; then
  echo "Error: You've entered an empty extension for current files."
  exit 1
fi

# Check if the extension has a leading dot and prompt the user to remove it
if [[ $current == .* ]]; then
  echo "Warning: Please enter extensions without a leading dot (e.g., ogg instead of .ogg)"
  exit 1
fi

# Initialize an array variable
files=()

# Save the current IFS
OLDIFS=$IFS

# Change IFS to handle filenames with spaces
IFS=$'\n'

# Check if maxdepth is empty or an integer
if [ -z "$maxdepth" ]; then
  # Find and store files in all directories in the array
  files=($(find "$directory" -type f -name "*.$current"))
elif [ "$maxdepth" -eq "$maxdepth" ] 2>/dev/null; then
  # Find and store files in the parent directory in the array
  files=($(find "$directory" -maxdepth 1 -type f -name "*.$current"))
else
  # Invalid maxdepth value
  echo "Invalid maxdepth value: $maxdepth. Please try again."
  exit 1
fi

# Restore the IFS
IFS=$OLDIFS

# Check if the array is empty and prompt the user
if [ ${#files[@]} -eq 0 ]; then
  echo "No files with the extension '$current' found in the directory '$directory'."
else
  # Loop through the array and open each file
  for file in "${files[@]}"; do
    echo "Opening file: $file" # Print the file path
    if [ -f "$file" ]; then
      xdg-open "$file"
    else
      echo "File does not exist: $file" # Print an error message if the file does not exist
    fi
  done
fi

