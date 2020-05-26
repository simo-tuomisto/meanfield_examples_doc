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

Copy `run_sample_puhti.sh` and `start_sample_puhti.sh` to samples-directory


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
