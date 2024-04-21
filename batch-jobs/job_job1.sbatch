#!/bin/bash
#SBATCH --job-name=job1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4:00:00
#SBATCH -o ./slurm-output/output.%j.out # STDOUT

module load gcc
module load omp

./compiled-programs/job1_cOpenMP.c 10 1 1 job1 1 1
