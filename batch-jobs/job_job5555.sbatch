#!/bin/bash
#SBATCH --job-name=job5555
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=5
#SBATCH --time=4:00:00
#SBATCH -o ./slurm-output/output.%j.out # STDOUT

module load gcc
module load openmpi

./program 5 10 5 job5555 1 1
