# Running samples

## Puhti

### Setting up the repository and getting slurm scripts

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

### Before running the samples

All samples can be run in the same fashion. You can use the commands below, but
first set the `$SAMPLE_NAME` environment variable:

- Isotropic alpha - `export SAMPLE_NAME=isotropic_alpha`
- Jouve 2008 Benchmark A - `export SAMPLE_NAME=Jouve-2008-benchmarkA`
- Jouve 2008 Benchmark B - `export SAMPLE_NAME=Jouve-2008-benchmarkB`
- Jouve 2008 Benchmark B - `export SAMPLE_NAME=Jouve-2008-benchmarkB`
- Steenbeck-Krause 1969 model1 - `export SAMPLE_NAME=Steenbeck-Krause-1969-model1`

### Running the sample

Compile sample:
```sh
cd $PENCIL_HOME/samples/meanfield_special_e_tensor/$SAMPLE_NAME
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
python ../create_emftensors.py .
```

Run sample:
```sh
module purge
sbatch ../run_sample_puhti.sh

diff data/time_series.dat reference.out.double
```
