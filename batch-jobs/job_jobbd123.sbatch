#!/bin/bash
#SBATCH --job-name=jobbd123
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=3
#SBATCH --time=4:00:00
#SBATCH -o ./slurm-output/output.%j.out # STDOUT

module load gcc
module load openmpi

./program 4 6 3 jobbd123 1 1
