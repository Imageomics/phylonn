#!/bin/bash

#SBATCH --job-name=phylonn_tsne
#SBATCH --account=pzs1151
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gpus-per-node=1
#SBATCH --time=02:00:00
#SBATCH --output=logs/tsne_%j.log
#SBATCH --error=logs/tsne_%j.err

module load miniconda3/24.1.2-py310
module load cuda/11.8.0
conda activate phylonn
cd /users/PZS1151/llies/phylonn
mkdir -p logs

export WANDB_MODE=offline

echo "Phylo-NN t-SNE plots..."
python analysis/tsne.py --config analysis/configs/tsne.yaml

echo "All done!"

