#!/bin/bash
#SBATCH --job-name=pyharm-convert
#SBATCH --time=00:08:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=32

module load conda/latest
eval "$(conda shell.bash hook)"
conda activate /project/u2grc/Sofia/Simulations/KerrLow/conda-envs/pyharm

export PYTHONPATH=/work/pi_gkhanna_uri_edu/Sofia/pyharm:$PYTHONPATH

cd /project/u2grc/Sofia/Simulations/KerrLow/original_phdfFiles
mkdir -p h5_convertedFiles

pyharm-convert \
  -p h5_convertedFiles/ \
  *.phdf \
  --nthreads $SLURM_CPUS_PER_TASK
