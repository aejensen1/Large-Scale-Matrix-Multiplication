#!/bin/bash
#SBATCH --job-name=small-test
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4:00:00
#SBATCH --output=small-test.out
#SBATCH --error=small-test.err

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
# ./program 5 10
