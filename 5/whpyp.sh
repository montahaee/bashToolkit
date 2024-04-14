#!/bin/bash

# Default directory is the current directory
directory="."

# Check if the first argument is a directory
if [ -d "$1" ]; then
  # Set the directory to the first argument
  directory="$1"
  # Shift the positional parameters by one
  shift
fi

# Directory where the wheelhouse is located
WHEELHOUSE_DIR=~/wheelhouse

# Function to update wheels in the wheelhouse
update_wheelhouse() {
    echo "Updating the wheelhouse..."
    # Upgrade the wheel package
    pip install --upgrade wheel

    # Update packages in the wheelhouse
    for package in $(ls $WHEELHOUSE_DIR/*.whl | xargs -n1 basename | cut -d '-' -f1 | uniq); do
        pip wheel --no-cache-dir --wheel-dir=$WHEELHOUSE_DIR $package
    done
}

# Function to install all packages from the wheelhouse into a project's virtual environment
install_all_from_wheelhouse() {                                                 
    local project_venv_path=$1                                                  
                                                                                
    # Activate the project's virtual environment                                
    source $project_venv_path/bin/activate                                      
                                                                                
    # Install all packages from the wheelhouse                                  
    for whl_file in $WHEELHOUSE_DIR/*.whl; do                                   
        pip install --no-index --find-links=$WHEELHOUSE_DIR $whl_file
    done                                                                        
                                                                                
    # Deactivate the virtual environment                                        
    deactivate                                                                  
}

# Call the functions
update_wheelhouse
install_all_from_wheelhouse $directory
