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
    # Unzip contents directly into the destination folder without subfolders
    unzip -o "$zip_file" -d "$DESTINATION_FOLDER" && find "$DESTINATION_FOLDER" -mindepth 2 -type f -exec mv -t "$DESTINATION_FOLDER" {} + && find "$DESTINATION_FOLDER" -mindepth 1 -type d -exec rm -rf {} + || {
      echo "Failed to unzip $zip_file"
      exit 1
    }
  else
    echo "No zip files found in $SOURCE_FOLDER"
  fi
done

echo "All zip files have been unzipped to $DESTINATION_FOLDER without creating subfolders."

pip install --no-index --find-links=$DESTINATION_FOLDER numpy tenacity seaborn langdetect scipy google pydantic scikit-learn matplotlib rich requests openpyxl deepeval googletrans pandas vertexai spacy tqdm typo evaluate datasets py_trans pytz gensim textblob python-dotenv
