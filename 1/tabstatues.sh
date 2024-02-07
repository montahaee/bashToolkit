#!/bin/bash

# Initialize variables
directory="."
max_mode=0
max_file=0
declare -A file_changes  # Associative array to store file changes

# Read git status and find max lengths
while read mode file; do
  len_mode=${#mode}
  len_file=${#file}
  if ((len_mode > max_mode)); then
    max_mode=$len_mode
  fi
  if ((len_file > max_file)); then
    max_file=$len_file
  fi

  # Store file change in the associative array, excluding lines with error messages
  if ! [[ "$file" =~ ^stat: ]]; then
    file_changes["$file"]+="$mode"
  fi
done < <(git status -s 2>&1 | grep -v '^stat:')

# Process files and display in tabular format with associated deletion timestamp
for file in "${!file_changes[@]}"; do
  modes="${file_changes["$file"]}"

  if [[ "$modes" =~ D && "$modes" =~ \?\? ]]; then
    # File is both created and deleted, possibly renamed
    deletion_timestamp=""
    for ((i = 1; i <= ${#file}; i++)); do
      substr="${file:0:i}"
      if [ "${file_changes["$substr"]}" == "??" ]; then
        deletion_timestamp="$(date +'%Y-%m-%d %H:%M:%S')"
        break
      fi
    done

    # Print created and deleted file with associated deletion timestamp
    printf "\033[31m??D%-*s\033[0m \033[31m%-*s\033[0m \033[33m%s\033[0m\n" $((max_mode - 2)) " " $((max_file + 4)) "$file" "$deletion_timestamp"
  else
    # Other file changes
    timestamp=""
    if [ "$modes" != "" ]; then
      if [ -f "$file" ]; then
        timestamp="$(stat -c %y "$file")"
      else
        timestamp=""
      fi
    fi
    printf "\033[31m%-*s\033[0m \033[32m%-*s\033[0m \033[33m%s\033[0m\n" $((max_mode + 4)) "$modes" $((max_file + 4)) "$file" "$timestamp"
  fi
done | grep -v '^stat:' | sort -k3r

if [ ${#file_changes[@]} -eq 0 ]; then
  echo 'No changes in this branch!'
fi

