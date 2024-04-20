#!/bin/bash
#SBATCH --job-name=job-38
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=5
#SBATCH --time=4:00:00
#SBATCH -o ./slurm-output/output.%j.out # STDOUT

module load gcc
module load openmpi

./program 4 11 5 job-38 1 1
