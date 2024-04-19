#!/bin/bash

# Define a function to print the time delta
print_time_delta() {
    echo "Time Delta: $1 seconds"
    echo "-------------------"
    echo ""
}

# Function to execute C program and calculate time delta
execute_c_program() {
    local filename=$1
    local size=$2
    local num_threads=$3
    local flag=$4
    local extra_flags=""

    case "$flag" in
        "fopenmp") extra_flags="-fopenmp" ;;
        "lpthread") extra_flags="-lpthread" ;;
    esac

    echo ""
    echo "------------------"
    echo ""
    echo "Beginning C Program: $filename with size $size and threads $num_threads"
    echo ""
    echo "------------------"
    echo ""

    start_time=$(date +%s%N) # nanoseconds

    gcc -o program "$filename" $extra_flags && ./program "$size" "$num_threads"

    end_time=$(date +%s%N) # nanoseconds

    time_delta=$(echo "scale=4; ($end_time - $start_time) / 1000000000" | bc)
    echo "Execution Time: $time_delta seconds"
}

# Function to execute Python script and calculate time delta
execute_python_script() {
    local filename=$1
    local size=$2
    local num_threads=$3

    echo ""
    echo "------------------"
    echo ""
    echo "Beginning Python Script: $filename with size $size and threads $num_threads"
    echo ""
    echo "------------------"
    echo ""

    start_time=$(date +%s%N) # nanoseconds

    python "$filename" "$size" "$num_threads"

    end_time=$(date +%s%N) # nanoseconds

    time_delta=$(echo "scale=4; ($end_time - $start_time) / 1000000000" | bc)
    echo "Execution Time: $time_delta seconds"
}

# Prompt user for a number
echo "Please enter the number of rows/columns for matrix multiplication: "
read size

# Check if input is a number. If not, exit the script.
if ! [[ "$size" =~ ^[0-9]+$ ]] || [ "$size" -le 0 ]; then
    echo "Error: Input is not a valid positive number. Exiting the script."
    exit 1
fi

# Prompt user for the number of threads
echo "Please enter the number of threads to use: "
read num_threads

# Check if number of threads is a number. If not, exit the script.
if ! [[ "$num_threads" =~ ^[0-9]+$ ]] || [ "$num_threads" -le 0 ]; then
    echo "Error: Number of threads is not a valid positive number. Exiting the script."
    exit 1
fi

# Execute the scripts with the user-specified size and number of threads
echo "Beginning Test Script!"
echo ""
echo "------------------"
echo ""

#execute_python_script "pythonNoThreads.py" "$size" # Not threaded, no need for $num_threads
#execute_python_script "pythonWithThreads.py" "$size" "$num_threads"
#execute_c_program "cNoThread.c" "$size" "1" # Assuming 1 thread for non-threaded C program
execute_c_program "cPThread.c" "$size" "$num_threads" "lpthread"
execute_c_program "cOpenMP.c" "$size" "$num_threads" "fopenmp"

echo ""
echo "------------------"
echo ""
echo "Consolidating reports..."
cat pythonNoThreads_stats.txt pythonWithThreads_stats.txt cNoThread_stats.txt cPThread_stats.txt cOpenMP_stats.txt > report.txt
echo "Report generated: report.txt"
echo ""
echo "------------------"
echo ""

rm pythonNoThreads_stats.txt pythonWithThreads_stats.txt cNoThread_stats.txt cPThread_stats.txt cOpenMP_stats.txt

echo "End of Script!"
