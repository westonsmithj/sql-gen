#!/bin/bash

# Function to print usage
print_usage() {
    echo "Usage: $0 <statement file> <data file> -o <output file>"
    exit 1
}

# Check if at least 4 arguments are passed
if [ "$#" -ne 4 ]; then
    print_usage
fi

# Check for the output option
if [ "$3" != "-o" ]; then
    print_usage
fi

STATEMENT_FILE=$1
DATA_FILE=$2
OUTPUT_FILE=$4

# Check if the statement file exists
if [ ! -f "$STATEMENT_FILE" ]; then
    echo "Error: Statement file '$STATEMENT_FILE' not found."
    exit 1
fi

# Check if the data file exists
if [ ! -f "$DATA_FILE" ]; then
    echo "Error: Data file '$DATA_FILE' not found."
    exit 1
fi

# Read the entire statement template from the file
STATEMENT_TEMPLATE=$(cat "$STATEMENT_FILE")

# Empty the output file if it already exists
> "$OUTPUT_FILE"

# Process each line in the data file
while IFS= read -r line || [[ -n "$line" ]]; do
    # Assuming comma-separated values in the data file
    IFS=',' read -r -a columns <<< "$line"
    
    # Create a temporary statement variable to process replacements
    temp_statement="$STATEMENT_TEMPLATE"
    
    # Replace each placeholder with the corresponding column value
    for (( i=0; i<${#columns[@]}; i++ )); do
        # Placeholder format is expected to be {n} where n is the column index (starting from 0)
        temp_statement=${temp_statement//\{${i}\}/${columns[$i]}}
    done
    
    # Append the processed statement to the output file and add a blank line for readability
    echo "$temp_statement" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
done < "$DATA_FILE"

