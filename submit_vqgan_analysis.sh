#!/bin/bash

#SBATCH --job-name=vqgan_analysis

#SBATCH --account=pzs1151

#SBATCH --nodes=1

#SBATCH --ntasks=1

#SBATCH --cpus-per-task=8

#SBATCH --gpus-per-node=1

#SBATCH --time=04:00:00

#SBATCH --output=logs/vqgan_analysis_%j.log

#SBATCH --error=logs/vqgan_analysis_%j.err



module load miniconda3/24.1.2-py310

module load cuda/11.8.0

conda activate phylonn

cd /users/PZS1151/llies/phylonn

mkdir -p logs



export WANDB_MODE=offline



echo "Step 1: Generating code histograms..."

python analysis/code_histogram_vqgan.py --config analysis/configs/code_histogram_vqgan.yaml



echo "Step 2: Generating histogram distance matrices..."

python analysis/generate_histograms_matrix_vqgan.py --config analysis/configs/generate_histograms_matrix_vqgan.yaml



echo "Step 3: Correlation scores (morphological)..."

python analysis/get_correlation.py --config analysis/configs/get_correlation-vanilla_vqgan-morphology.yaml



echo "Step 4: Correlation scores (phylogenetic)..."

python analysis/get_correlation.py --config analysis/configs/get_correlation-vanilla_vqgan-phylogeny.yaml



echo "All done!"

