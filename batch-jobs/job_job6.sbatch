#!/bin/bash
#SBATCH --job-name=job6
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4:00:00
#SBATCH -o ./slurm-output/output.%j.out # STDOUT

module load gcc

./compiled-programs/job6_cOpenMP.c 20 1 1 job6 1 1
