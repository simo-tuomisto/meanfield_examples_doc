#!/bin/bash -l
#SBATCH -A ituomine
#SBATCH --time=00:05:00
#SBATCH -n 4
#SBATCH --mem=2G
#SBATCH -p test
#SBATCH -o start_sample.out

module purge
module load StdEnv
module load hdf5/1.10.4-mpi

PENCIL_HOME=/scratch/ituomine/tuomiss1/pencil-code2
. ${PENCIL_HOME}/sourceme.sh

pc_start
