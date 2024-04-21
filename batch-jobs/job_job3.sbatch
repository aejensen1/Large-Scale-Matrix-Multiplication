#!/bin/bash
#SBATCH --job-name=job3
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4:00:00
#SBATCH -o ./slurm-output/output.%j.out # STDOUT

module load python

python "pythonWithThreads.py" 10 1 1 job3 1 1
