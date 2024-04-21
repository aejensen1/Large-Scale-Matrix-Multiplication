#!/bin/bash
#SBATCH --job-name=job7777
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=5
#SBATCH --time=4:00:00
#SBATCH -o ./slurm-output/output.%j.out # STDOUT

module load python

python pythonWithThreads.py 5 10 5 job7777 1 1
