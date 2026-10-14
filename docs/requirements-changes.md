python3 -c "

content = '''# Requirements Changes



This document records every change made to requirements.txt and the reasoning behind each one.



## Removed: MODELS==0.9.7

No PyPI package with this name exists at version 0.9.7. Investigated as possibly referencing the lowercase \`models\` package, but that package tops out at version 0.9.3. A grep of the entire codebase confirms no file imports a package called \`models\` — the only related import is \`from torchvision import models\` in lpips.py, which references PyTorch built-in models. This entry is a dead/erroneous line with no impact on functionality.



## Removed: skimage==0.0

A known dummy/placeholder package on PyPI that exists only to redirect users to scikit-image, which is already listed separately as \`scikit_image==0.19.3\`.



## Changed: matplotlib==3.6.1 to matplotlib>=3.6.1

seaborn==0.12.2 explicitly requires \`matplotlib!=3.6.1\`, causing a dependency conflict. Loosening the constraint allows pip to resolve to 3.7.5 which satisfies both.



## Changed: torch==1.7.0+cu110 to torch==1.13.1+cu117

The original CUDA 11.0 build is unavailable on OSC Ascend, which supports CUDA 11.8+. Upgraded to the closest compatible version. This is a more significant change that required additional fixes — see runtime-fixes.md.



## Changed: torchvision==0.8.1+cu110 to torchvision==0.14.1+cu117

Matches the PyTorch upgrade above. These two packages must stay version-matched.



## Changed: packaging==21.3

transformers==4.3.1 dependency checker uses version string formats incompatible with newer packaging versions, causing an InvalidVersion error on startup. Downgrading packaging to 21.3 resolves this.

'''

open('docs/requirements-changes.md', 'w').write(content)

print('done')

"
