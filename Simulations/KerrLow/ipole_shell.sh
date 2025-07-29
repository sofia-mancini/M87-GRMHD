#!/bin/bash
#SBATCH --job-name=ipole-render
#SBATCH --time=00:08:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=32

module load conda/latest
conda activate /project/u2grc/Sofia/Simulations/KerrLow/conda-envs/ipole

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
IPOLE_BIN=/work/pi_gkhanna_uri_edu/Sofia/ipole/build_archive/ipole

DATA_DIR=/project/u2grc/Sofia/Simulations/KerrLow/h5_convertedFiles
OUT_DIR=/project/u2grc/Sofia/Simulations/KerrLow/ipole_images-1
#N-turns=1
# OUT_DIR=/project/u2grc/Sofia/Simulations/KerrLow/ipole_images
mkdir -p "$OUT_DIR"

set -e

cd "$DATA_DIR"

for f in *.h5; do
  base="${f%.h5}"

  "$IPOLE_BIN" \
    -par /work/pi_gkhanna_uri_edu/Sofia/ipole/model/iharm/example.par \
    --dump="$DATA_DIR/$f" \
    --outfile="$OUT_DIR/${base}.h5"
done