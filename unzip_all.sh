#!/bin/bash

# Function to display an error message and exit if no argument is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <source-folder-containing-zips> <destination-folder>"
  exit 1
fi

# Source folder containing zip files
SOURCE_FOLDER="$1"
# Destination folder to store all unzipped content
DESTINATION_FOLDER="$2"

# Create the destination folder if it doesn't exist
mkdir -p "$DESTINATION_FOLDER"

# Iterate over all .zip files in the source folder
for zip_file in "$SOURCE_FOLDER"/*.zip; do
  if [ -f "$zip_file" ]; then
    echo "Unzipping $zip_file ..."
    unzip -o "$zip_file" -d "$DESTINATION_FOLDER" || {
      echo "Failed to unzip $zip_file"
      exit 1
    }
  else
    echo "No zip files found in $SOURCE_FOLDER"
  fi
done

echo "All zip files have been unzipped to $DESTINATION_FOLDER"
