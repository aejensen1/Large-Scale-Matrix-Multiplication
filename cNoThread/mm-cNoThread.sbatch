#!/bin/bash
#SBATCH --job-name=matrix_multiply_c
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cores-per-task=16
#SBATCH --time=1:00:00

# Load any necessary modules
# module load <module_name>

# Execute your program
./matrix_multiply_c

