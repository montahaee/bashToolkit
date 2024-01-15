#!/bin/bash

# This script checks for upgradable packages using the apt command and prompts the user to install them one by one.

upgradable=$(sudo apt list --upgradable 2>/dev/null | grep -oP "^[^\s/]+")
if [ -z "$upgradable" ]; then
  echo "No upgradable packages found."
  exit 0
else
  for package in $upgradable; do
    read -p "Install $package? (yes/no): " answer
    if [ "$answer" == "yes" ]; then
      sudo apt-get install --only-upgrade $package -y
    fi
  done
fi

