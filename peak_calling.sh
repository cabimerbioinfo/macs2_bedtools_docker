#!/bin/bash

# Define function to call MACS2
callMacs2() {
    local file="$1"
    local format="$2"
    local genome_size="$3"
    local keep_dup="$4"
    local control="$5"  # Optional control file
    local broad="$6"    # Optional argument --broad

    # Extract the filename without extension
    filename=$(basename -- "$file")
    filename_no_ext="${filename%.*}"

    # MACS2 callpeak command
    cmd="macs2 callpeak -t '$file' -f '$format' -g '$genome_size' --keep-dup '$keep_dup' -n '$filename_no_ext'"

    # Add control file to the command if provided
    if [ -n "$control" ]; then
        cmd="$cmd -c '$control'"
    fi

    # Add --broad argument to the command if specified
    if [ "$broad" == "--broad" ]; then
        cmd="$cmd --broad"
    fi

    # Execute the command
    eval "$cmd"
}

# Check if the necessary arguments are provided
if [ "$#" -lt 4 ]; then
    echo "Usage: $0 <input_file> <format> <genome_size> <keep_dup> [<control_file>] [--broad]"
    exit 1
fi

# Assign values to variables
input_file="$1"
format="$2"
genome_size="$3"
keep_dup="$4"
control_file="$5"  # This argument is optional
broad="$6"         # Optional argument --broad

# Call the function to execute MACS2
callMacs2 "$input_file" "$format" "$genome_size" "$keep_dup" "$control_file" "$broad"

