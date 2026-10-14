#!/bin/bash

#SBATCH --job-name=lsf_analysis
#SBATCH --account=pzs1151
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gpus-per-node=1
#SBATCH --time=04:00:00
#SBATCH --output=logs/lsf_analysis_%j.log
#SBATCH --error=logs/lsf_analysis_%j.err

module load miniconda3/24.1.2-py310
module load cuda/11.8.0
conda activate phylonn
cd /users/PZS1151/llies/phylonn
mkdir -p logs

export WANDB_MODE=offline

echo "Step 1: LSF t-SNE plots..."
python analysis/tsne.py --config analysis/configs/tsneLSF.yaml

echo "Step 2: LSF specimen translation..."
python analysis/translateLSF.py --config analysis/configs/translateLSF.yaml

echo "All done!"

