#!/bin/bash
#SBATCH --job-name=run_quickAnalysis
#SBATCH --time=00:08:00
#SBATCH --mem=4G

module load conda/latest
conda activate /project/u2grc/Sofia/Simulations/KerrLow/conda-envs/quickAnalysis

DATA_DIR=/project/u2grc/Sofia/Simulations/KerrLow/ipole_images-1
WORK_DIR=/work/pi_gkhanna_uri_edu/Sofia/QuickImageStats
OUT_FILE=/project/u2grc/Sofia/Simulations/KerrLow/average.h5

cd "$DATA_DIR"

export PYTHONPATH=/work/pi_gkhanna_uri_edu/Sofia:$PYTHONPATH

files=( *.h5)
python "$WORK_DIR/average_hdf5_data-2.py" "$OUT_FILE" "${files[@]}"

python -m QuickImageStats.quick_analysis "$OUT_FILE"