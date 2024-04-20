#!/bin/bash
#SBATCH --job-name=job-44
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=7
#SBATCH --time=4:00:00
#SBATCH -o ./slurm-output/output.%j.out # STDOUT

module load python

python pythonWithThreads.py 11 15 7 job-44 1 1
