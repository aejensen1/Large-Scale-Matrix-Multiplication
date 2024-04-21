#!/bin/bash
#SBATCH --job-name=job5
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4:00:00
#SBATCH -o ./slurm-output/output.%j.out # STDOUT

module load python

python "pythonNoThreads.py" 10 1 1 job5 1 1
