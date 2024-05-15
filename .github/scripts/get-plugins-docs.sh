#!/bin/bash
if [ -z "$SOURCE_EDITOR_URL" ]; then
    echo "Variable SOURCE_EDITOR_URL not found"
    exit 1
else
    echo "Found env with source editor url!"
fi

FILES_LIST_URL="$SOURCE_EDITOR_URL/markdown-docs/files.txt"
PROJECT_DIR="."
echo "URL: $FILES_LIST_URL"
# Destination directory where files will be saved
DESTINATION_DIR="$PROJECT_DIR/docs/panel/PluginsDevelopment"

# Fetch the list of files
FILES=$(curl -s "$FILES_LIST_URL" $FILES_LIST_URL| grep 'PluginDocs')

# Create destination directory if it doesn't exist
mkdir -p "$DESTINATION_DIR"

while IFS= read -r FILE; do
    # Skip empty lines
    if [ -z "$FILE" ]; then
        continue
    fi
    # Create parent directories if they don't exist
    PARENT_DIR=$(dirname "$FILE")
    mkdir -p "$DESTINATION_DIR/$PARENT_DIR"

    # Download the file
    echo "Downloading $FILE..."
    curl -s -o "$DESTINATION_DIR/$FILE" "$SOURCE_EDITOR_URL/markdown-docs/$FILE"
done <<<"$FILES"

# Directory with Plugins API Reference .md files
MD_FILES_DIRECTORY="$DESTINATION_DIR/PluginDocs"

# File with section ordered list
INDEX_FILE="$MD_FILES_DIRECTORY/index.md"
# Delete spaces before markdown code
sed -i.bak 's/^\s*#/#/' "$INDEX_FILE"

# Extract the file names in reverse order
FILES=$(grep -o '\(.*\)' "$INDEX_FILE" | awk -F '[()]' '{print $2}' | sed 's/\.\/\([^\/]*\)/\1/' | tr ' ' '\n' | xargs)

# Clean the Events file to reduce the number of items in the navigation
find $MD_FILES_DIRECTORY -type f -iname '*Events.md' | xargs sed -Ei.bak 's/## event `"(.*)"`/## `\1`/g'
find $MD_FILES_DIRECTORY -type f -iname '*Events.md' | xargs sed -Ei.bak "s|#### (Supported results)|<div markdown=1 style='font-weight: bold;font-size: 1.1em'>\1</div>|g"
find $MD_FILES_DIRECTORY -type f -iname '*Events.md' | xargs sed -Ei.bak "s|#### (Event class: .*)|<div markdown=1 style='font-weight: bold;font-size: 1.1em'>\1</div>|g"

# Loop through each file name and process them
ITER=0
for FILE in $FILES; do
    ORIGINAL_FILE="$FILE"
    FILE="${ITER}_${ORIGINAL_FILE}"
    mv $MD_FILES_DIRECTORY/$ORIGINAL_FILE $MD_FILES_DIRECTORY/$FILE
    echo "renaming $ORIGINAL_FILE to $FILE"
    find $MD_FILES_DIRECTORY -type f -iname '*.md' | xargs sed -i.bak "s/${ORIGINAL_FILE}/${FILE}/g"
    # Delete divs and TOCs
    sed -i.bak 's/^# Flotiq UI Plugins Reference: /# /g' "$MD_FILES_DIRECTORY/$FILE"
    sed -i.bak 's/<div /<div markdown="1"/g' "$MD_FILES_DIRECTORY/$FILE"
    sed -i.bak 's#.docs/public/#../#g' "$MD_FILES_DIRECTORY/$FILE"
    sed -i.bak '/\[\[_TOC_\]\]/d' "$MD_FILES_DIRECTORY/$FILE"
    
    ITER=$(expr $ITER + 1)
done

find $PROJECT_DIR -type f -iname '*.bak' -exec rm {} \;
