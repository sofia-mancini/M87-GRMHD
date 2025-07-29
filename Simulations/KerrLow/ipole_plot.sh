#!/bin/bash
#SBATCH --job-name=make-ipole-movie
#SBATCH --time=00:08:00
#SBATCH --mem=4G

# Uncomment line 7 for n-turns=1
# IN_DIR=/project/u2grc/Sofia/Simulations/KerrLow/ipole_images
IN_DIR=/project/u2grc/Sofia/Simulations/KerrLow/ipole_images-1
OUT_DIR=/project/u2grc/Sofia/Simulations/KerrLow
MOVIE=/project/u2grc/Sofia/Simulations/KerrLow/out-1_Stokes.mp4

FRAMERATE=8

module load conda/latest
conda activate /project/u2grc/Sofia/Simulations/KerrLow/conda-envs/ipole

cd "$IN_DIR"

rm -f *.png

python /work/pi_gkhanna_uri_edu/Sofia/ipole/scripts/plot_pol.py ./*.h5

ffmpeg -y -framerate 8 -pattern_type glob -i '*.png' -s:v 1280x720 -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p "$MOVIE"