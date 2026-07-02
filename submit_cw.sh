#!/bin/bash

#SBATCH --job-name=cw_training

#SBATCH --account=pzs1151

#SBATCH --nodes=1

#SBATCH --ntasks=1

#SBATCH --cpus-per-task=8

#SBATCH --gpus-per-node=1

#SBATCH --time=96:00:00

#SBATCH --output=logs/cw_%j.log

#SBATCH --error=logs/cw_%j.err



module load miniconda3/24.1.2-py310

module load cuda/11.8.0

conda activate phylonn

cd /users/PZS1151/llies/phylonn

mkdir -p logs



export WANDB_MODE=offline



python main.py --prefix logs --name cw_baseline --postfix v1 --base configs/cw_model.yaml -t True --gpus 0, --accelerator dp

