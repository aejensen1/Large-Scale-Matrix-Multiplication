#!/bin/bash
#SBATCH --job-name=job6666
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=5
#SBATCH --time=4:00:00
#SBATCH -o ./slurm-output/output.%j.out # STDOUT

module load python

python pythonNoThreads.py 5 10 5 job6666 1 1
