# Running samples

## Puhti

### Common steps

Clone pencil-code and check out a version that compiles:
```sh
git clone https://github.com/pencil-code/pencil-code.git pencil-code2
cd pencil-code2
git checkout 900fd0187d67ecd318f6a846cd17d8f6fe1052dc
source sourceme.sh
```

Fix `import pencil` to `import pencil_old` in `create_emftensors`:
```sh
cd samples/meanfield_special_e_tensor
sed -i 's/import pencil/import pencil_old/g' create_emftensors.py
```

Create `run_sample.sh` and `run_start.sh` to 


`start_sample.sh`:
```sh
```

`run_sample.sh`:
```sh
#!/bin/bash -l
#SBATCH -A ituomine
#SBATCH --time=00:15:00
#SBATCH -n 4
#SBATCH --mem=2G
#SBATCH -p test

module purge
module load StdEnv
module load hdf5/1.10.4-mpi

PENCIL_HOME=/scratch/ituomine/tuomiss1/pencil-code2
. ${PENCIL_HOME}/sourceme.sh

pc_run
```

### Isotropic alpha

Compile sample:
```sh
cd $PENCIL_HOME
cd samples/meanfield_special_e_tensor/isotropic_alpha/
module purge
module load StdEnv
module load hdf5/1.10.4-mpi 
pc_setupsrc
pc_build -f compilers/Intel_MPI REAL_PRECISION=double
```

# Run start
```sh
mkdir data
srun -n 4 -t 00:05:00 --mem=2G -A ituomine -p test pc_start
```

Create emftensors:
```sh
module purge
module load python-env
python ../create_emftensors.py .
```

Something strange happens after running the previous command and start needs to be run again:
```sh
cp data/emftensors.h5 .
rm -r data
module purge
module load StdEnv
module load hdf5/1.10.4-mpi 
srun -n 4 -t 00:05:00 --mem=2G -A ituomine -p test pc_start
cp emftensors.h5 data
```

Run sample:

```sh
module purge
module load StdEnv
module load hdf5/1.10.4-mpi 
srun -n 4 -t 00:15:00 --mem=2G -A ituomine -p test pc_run

diff data/time_series.dat reference.out.double
```

### Jouve 2008 Benchmark A

Compile sample:
```sh
cd samples/meanfield_special_e_tensor/Jouve-2008-benchmarkA
module purge
module load StdEnv
module load hdf5/1.10.4-mpi 
pc_setupsrc
pc_build -f compilers/Intel_MPI REAL_PRECISION=double
```

Run start:
```sh
mkdir data
srun -n 4 -t 00:05:00 --mem=2G -A ituomine -p test pc_start
```

Create emftensors:
```sh
module purge
module load python-env
sed -i 's/import pencil/import pencil_old/g' ../create_emftensors.py
python ../create_emftensors.py .
```

Something strange happens after running the previous command and start needs to be run again:
```sh
cp data/emftensors.h5 .
rm -r data
module purge
module load StdEnv
module load hdf5/1.10.4-mpi 
srun -n 4 -t 00:05:00 --mem=2G -A ituomine -p test pc_start
cp emftensors.h5 data
```

Run sample:
```sh
module purge
module load StdEnv
module load hdf5/1.10.4-mpi 
srun -n 4 -t 00:15:00 --mem=2G -A ituomine -p test pc_run

diff data/time_series.dat reference.out.double
```
