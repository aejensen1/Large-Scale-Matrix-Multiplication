#!/bin/bash

# Function to print the time delta
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

    # Compile C program
    gcc -o program "$filename" $extra_flags

    # Execute C program
    ./program "$size" "$num_threads"

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

    # Execute Python script
    python "$filename" "$size" "$num_threads"

    end_time=$(date +%s%N) # nanoseconds

    time_delta=$(echo "scale=4; ($end_time - $start_time) / 1000000000" | bc)
    echo "Execution Time: $time_delta seconds"
}

# Check if input is a number. If not, exit the script.
validate_number() {
    if ! [[ "$1" =~ ^[0-9]+$ ]] || [ "$1" -le 0 ]; then
        echo "Error: Input is not a valid positive number. Exiting the script."
        exit 1
    fi
}

# Parse command-line arguments
if [ "$#" -ne 5 ]; then
    echo "Usage: $0 <file_type> <array_size> <num_threads> <job_name>"
    echo "Available file types: cNoThread, cPThread, cOpenMP, pythonNoThreads, pythonWithThreads"
    exit 1
fi

file_type=$1
size=$2
num_threads=$3
job_name=$4

# Validate array size and number of threads
validate_number "$size"
validate_number "$num_threads"

# Generate Slurm batch job script
batch_job_script="job_${job_name}.sbatch"

cat <<EOF >"$batch_job_script"
#!/bin/bash
#SBATCH --job-name=$job_name
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=$num_threads
#SBATCH --time=1:00:00

# Load any necessary modules
# module load <module_name>

# Execute your program here
EOF

# Add execution command based on file type
case "$file_type" in
    "cNoThread")
        echo "./cNoThread $size" >>"$batch_job_script" ;;
    "cPThread")
        echo "./cPThread $size $num_threads" >>"$batch_job_script" ;;
    "cOpenMP")
        echo "./cOpenMP $size $num_threads" >>"$batch_job_script" ;;
    "pythonNoThreads")
        echo "python pythonNoThreads.py $size" >>"$batch_job_script" ;;
    "pythonWithThreads")
        echo "python pythonWithThreads.py $size $num_threads" >>"$batch_job_script" ;;
    *)
        echo "Error: Unsupported file type: $file_type. Exiting."
        exit 1
        ;;
esac

# Submit the Slurm batch job
echo "Submitting Slurm batch job..."
sbatch "$batch_job_script"

