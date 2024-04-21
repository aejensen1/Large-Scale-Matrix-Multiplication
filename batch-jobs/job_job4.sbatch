#!/bin/bash
#SBATCH --job-name=job4
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4:00:00
#SBATCH -o ./slurm-output/output.%j.out # STDOUT

module load gcc

./compiled-programs/job4_cNoThread.c 10 1 1 job4 1 1
