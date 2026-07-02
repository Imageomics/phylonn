#!/bin/bash

#SBATCH --job-name=phylonn_analysis

#SBATCH --account=pzs1151

#SBATCH --nodes=1

#SBATCH --ntasks=1

#SBATCH --cpus-per-task=8

#SBATCH --gpus-per-node=1

#SBATCH --time=04:00:00

#SBATCH --output=logs/analysis_%j.log

#SBATCH --error=logs/analysis_%j.err



module load miniconda3/24.1.2-py310

module load cuda/11.8.0

conda activate phylonn

cd /users/PZS1151/llies/phylonn

mkdir -p logs



export WANDB_MODE=offline



echo "Step 1: Generating code histograms..."

python analysis/code_histogram.py --config analysis/configs/code_histogram.yaml



echo "Step 2: Generating histogram distance matrices..."

python analysis/generate_histograms_matrix.py --config analysis/configs/generate_histograms_matrix.yaml



echo "Step 3: Computing correlation scores (morphological)..."

python analysis/get_correlation.py --config analysis/configs/get_correlation-phylonn-morphology.yaml



echo "Step 4: Computing correlation scores (phylogenetic)..."

python analysis/get_correlation.py --config analysis/configs/get_correlation-phylonn-phylogeny.yaml




