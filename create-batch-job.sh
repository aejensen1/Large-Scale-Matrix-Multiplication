#!/bin/bash

# Check if input is a number. If not, exit the script.
validate_number() {
    if ! [[ "$1" =~ ^[0-9]+$ ]] || [ "$1" -le 0 ]; then
        echo "Error: Input is not a valid positive number. Exiting the script."
        exit 1
    fi
}

# Parse command-line arguments
# Check if the number of arguments is equal to 7, otherwise print usage instruction
if [ "$#" -ne 7 ]; then
    echo "Usage: $0 <file_type> <array_size> <num_threads> <job_name> <num_nodes> <ntasks-per-node> <cores-per-task>"
    echo "Available file types: cNoThread, cPThread, cOpenMP, pythonNoThreads, pythonWithThreads"
    echo "Max number of threads: 256 (128 cores * 2 threads per core)"
    exit 1
fi

file_type=$1
array_size=$2
num_threads=$3 # Max = 256
job_name=$4
num_nodes=$5
ntasks_per_node=$6
cores_per_task=$7

# Validate file type
case "$file_type" in
    "cNoThread" | "cPThread" | "cOpenMP" | "pythonNoThreads" | "pythonWithThreads" | "cNoThread.c" | "cPThread.c" | "cOpenMP.c" | "pythonNoThreads.py" | "pythonWithThreads.py") ;;
    *)
	echo "Error: Unsupported file type: $file_type. Exiting."
	exit 1
	;;
esac

# Validate array size and number of threads
validate_number "$array_size"
validate_number "$num_threads"
validate_number "$num_nodes"
validate_number "$ntasks_per_node"
validate_number "$cores_per_task"

# Check that the number of threads is less than or equal to 256.
if [ "$num_threads" -gt 256 ]; then
    echo "Error: The number of threads cannot exceed 256. Exiting."
    exit 1
fi

# Calculate the number of cores needed
num_cores=$((num_threads / 2)) # Hyperthreading (2 threads per core)

# set is_c_program to true if the file type is a C program and compile the program with the appropriate flags
# set is_c_program to false if the file type is a Python script and copy the script to program.py
is_c_program=false
case "$file_type" in
    "cNoThread" | "cNoThread.c")
	is_c_program=true
	gcc -o program cNoThread.c ;;
    "cPThread | cPThread.c")
	is_c_program=true
	gcc -o program cPThread.c -lpthread ;;
    "cOpenMP" | "cOpenMP.c")
	is_c_program=true
	gcc -o program cOpenMP.c -fopenmp ;;
	"pythonNoThreads" | "pythonNoThreads.py")
	cp pythonNoThreads.py program.py ;;
	"pythonWithThreads" | "pythonWithThreads.py")
	cp pythonWithThreads.py program.py ;;
esac

# Generate Slurm batch job script
batch_job_script="job_${job_name}.sbatch"

# Write the Slurm batch job script with either C program or Python script execution
if [ "$is_c_program" = true ]; then
    cat <<EOF >"./batch-jobs/$batch_job_script"
#!/bin/bash
#SBATCH --job-name=$job_name
#SBATCH --nodes=$num_nodes
#SBATCH --ntasks-per-node=$ntasks_per_node
#SBATCH --cpus-per-task=$cores_per_task
#SBATCH --time=4:00:00
#SBATCH --output=$job_name.out
#SBATCH --error=$job_name.err

# Load any necessary modules
# module load <module_name>
# module load gcc
# module load python
# module load openmpi
# module load openmp
# module load pthread
# module load mpi
# module load stdio
# module load stdlib
# module load time
# module load omp

# Execute your program here
# ./program $array_size $num_threads
EOF
else
    cat <<EOF >"./batch-jobs/$batch_job_script"
#!/bin/bash
#SBATCH --job-name=$job_name
#SBATCH --nodes=$num_nodes
#SBATCH --ntasks-per-node=$ntasks_per_node
#SBATCH --cpus-per-task=$cores_per_task
#SBATCH --time=4:00:00
#SBATCH --output=$job_name.out
#SBATCH --error=$job_name.err
#
# Load any necessary modules
# module load <module_name>
# module load python
# module load sys
# module load time
# module load os
# module load threading
#
# Execute your program here
# python program.py $array_size $num_threads
EOF
fi

# Submit the Slurm batch job
echo "Submitting Slurm batch job with program $file_type and array size $array_size with $num_threads threads.."

sbatch "./batch-jobs/$batch_job_script"

echo "Slurm batch job submitted successfully."
