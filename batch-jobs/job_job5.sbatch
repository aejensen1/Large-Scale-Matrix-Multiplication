#!/bin/bash
#SBATCH --job-name=job5
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=4:00:00

module load gcc
module load openmpi

./program 5 20
