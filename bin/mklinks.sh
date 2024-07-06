#!/bin/bash

output_mount="/outputs"
if [ ! -d "$output_mount" ]; then echo "Output folder not mounted. Exiting."; exit -1 ; fi
data_mount="/data"
if [ ! -d "$data_mount" ]; then echo "Data folder not mounted. Exiting."; exit -1 ; fi

# Check if an argument was provided
if [ $# -eq 1 ]; then
    project_name="$1"
else
    # Get the current working directory name
    project_name=$(basename "$PWD")
fi

# Create the output directory
output_dir="/outputs/$project_name"
if [ ! -d "$output_dir" ]; then 
  mkdir -p "$output_dir"
  echo "Created directory: $output_dir"
fi
if [ ! -d "./outputs" ]; then 
  ln -s "$output_dir" "./outputs"
  echo "Linked directory: $output_dir -> ./outputs"
fi


# List the directories inside the /data folder
directories=$(ls -d $data_mount/*/)

echo "Directories in $data_mount:"
PS3="Select a directory to symlink (or type 'q' to quit): "

# Convert directories list to array
directories_array=($directories)

select dir in "${directories_array[@]}"; do
  if [[ $REPLY == "q" ]]; then
    echo "Exiting."
    break
  elif [[ -n $dir ]]; then
    # Get the directory name
    dir_name=$(basename "$dir")
    # creates project data dir if it doesn't exist
    if [ ! -d "./data" ]; then mkdir -p "./data"; fi
    # Create the symlink if it isn't linked yet
    if [ ! -d "./data/$dir_name" ]; then
      # Remove trailing slash from dir var
      dir=${dir%/}
      # if dataset doesn't contain subfolder with same name
      if [ ! -d "$dir/$dir_name" ]; then
        ln  -s  "$dir"  "./data/$dir_name"
        echo "Created symlink: ./data/$dir_name -> $dir"
      else
        # links subdirectory instead, if it exists.
        ln -s "$dir/$dir_name" "./data/$dir_name"
        echo "Created symlink: ./data/$dir_name -> $dir/$dir_name"
      fi
    else
      echo "You already created a symlink to this dataset"
    fi
  else
    echo "Invalid selection. Please try again."
  fi
done
