#!/bin/bash
#SBATCH --job-name=job-42
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=6
#SBATCH --time=4:00:00
#SBATCH -o ./slurm-output/output.%j.out # STDOUT

module load python

python pythonNoThreads.py 9 13 6 job-42 1 1
