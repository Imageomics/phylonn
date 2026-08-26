
"""
Generate side-by-side reconstruction images for Phylo-NN.
"""

import torch
import numpy as np
from PIL import Image
import os
from scripts.loading_utils import load_config, load_model
from scripts.models.phyloautoencoder import PhyloVQVAE
from scripts.data.custom import CustomTest as CustomDataset

PHYLONN_CKPT = "logs/logs/2026-06-26T11-24-38_phylonnv1/checkpoints/last.ckpt"
PHYLONN_YAML = "logs/logs/2026-06-26T11-24-38_phylonnv1/configs/2026-06-26T11-24-38-project.yaml"
FILE_LIST    = "dataset/fish_test.txt"
OUTDIR       = "logs/logs/2026-06-26T11-24-38_phylonnv1/figs/reconstructions"
DEVICE       = 0
INDICES      = [40, 47, 54, 100, 200, 300]

os.makedirs(OUTDIR, exist_ok=True)

print("Loading Phylo-NN model...")
config = load_config(PHYLONN_YAML, display=False)
model  = load_model(config, ckpt_path=PHYLONN_CKPT, cuda=True, model_type=PhyloVQVAE)
model.eval()

print("Loading dataset...")
dataset = CustomDataset(256, FILE_LIST, add_labels=True)

def tensor_to_pil(t):
    arr = ((t.squeeze().detach().cpu().numpy().transpose(1,2,0) + 1.0) * 127.5)
    arr = np.clip(arr, 0, 255).astype(np.uint8)
    return Image.fromarray(arr)

with torch.no_grad():
    for idx in INDICES:
        example = dataset.data[idx]
        img_tensor = torch.tensor(example["image"]).permute(2,0,1).unsqueeze(0).float().to(DEVICE)
        zq_phylo, zq_nonphylo, _, _, _, encoder_out, _, _ = model.encode(img_tensor)
        reconstruction = model.decode(zq_phylo, zq_nonphylo)
        if isinstance(reconstruction, tuple): reconstruction = reconstruction[0]
        if isinstance(reconstruction, tuple): reconstruction = reconstruction[0]

        orig_pil  = tensor_to_pil(img_tensor)
        recon_pil = tensor_to_pil(reconstruction)
        combined = Image.new("RGB", (520, 256), color=(40, 40, 40))
        combined.paste(orig_pil,  (0, 0))
        combined.paste(recon_pil, (264, 0))
        fname = os.path.join(OUTDIR, f"reconstruction_{idx:04d}.png")
        combined.save(fname)
        print(f"  Saved: {fname}")

images = [Image.open(os.path.join(OUTDIR, f"reconstruction_{i:04d}.png")) for i in INDICES]
grid = Image.new("RGB", (2*(520+8), 3*(256+8)), color=(40,40,40))
for i, img in enumerate(images):
    r, c = divmod(i, 2)
    grid.paste(img, (c*(528), r*(264)))
    
grid.save(os.path.join(OUTDIR, "reconstruction_grid.png"))
print("Done!")

