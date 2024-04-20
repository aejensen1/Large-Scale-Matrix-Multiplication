#!/bin/bash
#SBATCH --job-name=job1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=4:00:00

module load python

python program.py 5 20
