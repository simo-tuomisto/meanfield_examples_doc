#!/bin/bash
#SBATCH -A ituomine
#SBATCH --time=00:15:00
#SBATCH -n 4
#SBATCH --mem=2G
#SBATCH -p test
#SBATCH -o run_sample.out

module purge
module load StdEnv
module load hdf5/1.10.4-mpi

pc_run
