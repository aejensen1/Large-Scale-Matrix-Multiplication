#!/bin/bash

# Remove old batch files
# Check if batch-jobs directory contains files
if [ -n "$(find ./batch-jobs -maxdepth 1 -type f)" ]; then
    rm ./batch-jobs/*
fi

# Check if slurm-output directory contains files
if [ -n "$(find ./slurm-output -maxdepth 1 -type f)" ]; then
    rm ./slurm-output/*
fi

# Function to process each row
process_row() {
    local file_type=$1
    local array_size=$2
    local num_threads=$3
    local job_name=$4
    local num_nodes=$5
    local ntasks_per_node=$6

    # Call create-batch-job.sh with the extracted fields as arguments
    ./create-batch-job.sh "$file_type" "$array_size" "$num_threads" "$job_name" "$num_nodes" "$ntasks_per_node"

    # Remove the processed row from the CSV file
    sed -i '1d' ./jobs-queue.csv  # Remove the first line (header) from the file
}

# Read the CSV file line by line and process each row
while IFS=, read -r file_type array_size num_threads job_name num_nodes ntasks_per_node; do
    # Skip the header row
    if [[ $file_type == "file_type" ]]; then
        continue
    fi

    # Process the current row
    process_row "$file_type" "$array_size" "$num_threads" "$job_name" "$num_nodes" "$ntasks_per_node"

    # Generate a random delay between 15 and 30 seconds
    delay=$(( RANDOM % 24 + 7 ))
    echo "Waiting for $delay seconds before processing the next batch..."
    sleep $delay

done < ./jobs-queue.csv

echo "All rows processed successfully."

