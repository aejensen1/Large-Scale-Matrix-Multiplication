#!/bin/bash
#SBATCH --job-name=jobasc
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=3
#SBATCH --time=4:00:00
#SBATCH -o ./slurm-output/output.%j.out # STDOUT

module load python

python pythonWithThreads.py 4 6 3 jobasc 1 1
