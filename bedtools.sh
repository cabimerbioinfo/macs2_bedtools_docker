#!/bin/bash

# Check that the necessary arguments are provided
if [ "$#" -lt 6 ]; then
    echo "Usage: $0 <wt> <mutant> <peak_file_wt_1> <peak_file_wt_2> <peak_file_mut_1> <peak_file_mut_2>"
    exit 1
fi

# Assign arguments to variables
wt="$1"
mutant="$2"
peak_files=("${@:3:4}")  # Get the last 4 arguments as the list of peak files

# Construct the comp argument by joining wt and mutant with _
comp="${wt}_${mutant}"

# Define common file names
common_files=("${wt}_commonpeaks.bed" "${mutant}_commonpeaks.bed")

# Iterate over the peak files two at a time
j=0
for ((i=0; i < ${#peak_files[@]}; i+=2)); do
    # Perform the peak intersection
    bedtools intersect -wao -a "${peak_files[i]}" -b "${peak_files[i + 1]}" > "${common_files[j]}"

    # Filter rows where the 12th column is not -1
    awk '$12 != -1' "${common_files[j]}" > "${common_files[j]%.bed}_filtered.bed"
    ((j++))
done

# List of BED files
bed_files=("${wt}_commonpeaks_filtered.bed" "${mutant}_commonpeaks_filtered.bed")

# Output directory for the concatenated file
output="${comp}_cat_common_peaks.bed"

# Concatenate BED files using the cat command
cat "${bed_files[@]}" > "$output"

# Sort the concatenated file
sorted_output="${comp}_sorted_common_peaks.bed"
bedtools sort -i "$output" > "$sorted_output"

# Merge the sorted file
merged_output="${comp}_merged_common_peaks.bed"
bedtools merge -i "$sorted_output" > "$merged_output"

# Display the first few lines of the merged file
head "$merged_output"

