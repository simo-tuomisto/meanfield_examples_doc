# Running samples

## Puhti

### Common steps

Clone pencil-code and check out a version that compiles:
```sh
git clone https://github.com/pencil-code/pencil-code.git pencil-code-samples
cd pencil-code-samples
git checkout 900fd0187d67ecd318f6a846cd17d8f6fe1052dc
source sourceme.sh
```

Fix `import pencil` to `import pencil_old` in `create_emftensors`:
```sh
cd $PENCIL_HOME/samples/meanfield_special_e_tensor
sed -i 's/import pencil/import pencil_old/g' create_emftensors.py
```

Copy `run_sample_puhti.sh` and `start_sample_puhti.sh` into the same directory:
```sh
```

### Isotropic Alpha

Go to the sample directory:
```sh
cd $PENCIL_HOME/samples/meanfield_special_e_tensor/isotropic_alpha/
```

Compile sample:
```sh
module purge
module load StdEnv
module load hdf5/1.10.4-mpi 
pc_setupsrc
pc_build -f compilers/Intel_MPI REAL_PRECISION=double
```

# Run start
```sh
mkdir data
sbatch ../start_sample_puhti.sh
```

Create emftensors:
```sh
module purge
module load python-env
python ../create_emftensors.py .
```

Run sample:

```sh
sbatch ../run_sample_puhti.sh

diff data/time_series.dat reference.out.double
```

### Jouve 2008 Benchmark A

Compile sample:
```sh
cd $PENCIL_HOME/samples/meanfield_special_e_tensor/Jouve-2008-benchmarkA
module purge
module load StdEnv
module load hdf5/1.10.4-mpi 
pc_setupsrc
pc_build -f compilers/Intel_MPI REAL_PRECISION=double
```

Run start:
```sh
mkdir data
sbatch ../start_sample_puhti.sh
```

Create emftensors:
```sh
module purge
module load python-env
sed -i 's/import pencil/import pencil_old/g' ../create_emftensors.py
python ../create_emftensors.py .
```

Run sample:
```sh
sbatch ../run_sample_puhti.sh

diff data/time_series.dat reference.out.double
```
### Jouve 2008 Benchmark B

Compile sample:
```sh
cd $PENCIL_HOME/samples/meanfield_special_e_tensor/Jouve-2008-benchmarkB
module purge
module load StdEnv
module load hdf5/1.10.4-mpi 
pc_setupsrc
pc_build -f compilers/Intel_MPI REAL_PRECISION=double
```

Run start:
```sh
mkdir data
sbatch ../start_sample_puhti.sh
```

Create emftensors:
```sh
module purge
module load python-env
sed -i 's/import pencil/import pencil_old/g' ../create_emftensors.py
python ../create_emftensors.py .
```

Run sample:
```sh
sbatch ../run_sample_puhti.sh

diff data/time_series.dat reference.out.double
```
