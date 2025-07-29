#!/bin/bash
#SBATCH --job-name=run_quickAnalysis
#SBATCH --time=00:08:00
#SBATCH --mem=4G

module load conda/latest
conda activate /project/u2grc/Sofia/Simulations/KerrLow/conda-envs/quickAnalysis

python analyze_data.py