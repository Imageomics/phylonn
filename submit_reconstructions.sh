#!/bin/bash
#SBATCH --job-name=phylonn_recon
#SBATCH --account=pzs1151
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gpus-per-node=1
#SBATCH --time=00:30:00
#SBATCH --output=logs/recon_%j.log
#SBATCH --error=logs/recon_%j.err

module load miniconda3/24.1.2-py310
module load cuda/11.8.0
conda activate phylonn
cd /users/PZS1151/llies/phylonn
python make_phylonn_reconstructions.py
