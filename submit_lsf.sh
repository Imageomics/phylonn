#!/bin/bash

#SBATCH --job-name=lsf_training

#SBATCH --account=pzs1151

#SBATCH --nodes=1

#SBATCH --ntasks=1

#SBATCH --cpus-per-task=8

#SBATCH --gpus-per-node=1

#SBATCH --time=48:00:00

#SBATCH --output=logs/lsf_%j.log

#SBATCH --error=logs/lsf_%j.err



module load miniconda3/24.1.2-py310

module load cuda/11.8.0

conda activate phylonn

cd /users/PZS1151/llies/phylonn

mkdir -p logs



export WANDB_MODE=offline



python main.py --prefix logs --name lsf_baseline --postfix v1 --base configs/lsf.yaml -t True --gpus 0, --accelerator dp

