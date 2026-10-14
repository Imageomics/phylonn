import os

import sys

sys.path.insert(0, '/users/PZS1151/llies/phylonn')



from scripts.data.phylogeny import Phylogeny



species = [

    'Alosa chrysochloris', 'Carassius auratus', 'Cyprinus carpio', 'Esox americanus',

    'Gambusia affinis', 'Lepisosteus osseus', 'Lepisosteus platostomus', 'Lepomis auritus',

    'Lepomis cyanellus', 'Lepomis gibbosus', 'Lepomis gulosus', 'Lepomis humilis',

    'Lepomis macrochirus', 'Lepomis megalotis', 'Lepomis microlophus', 'Morone chrysops',

    'Morone mississippiensis', 'Notropis atherinoides', 'Notropis blennius', 'Notropis boops',

    'Notropis buccatus', 'Notropis buchanani', 'Notropis dorsalis', 'Notropis hudsonius',

    'Notropis leuciodus', 'Notropis nubilus', 'Notropis percobromus', 'Notropis stramineus',

    'Notropis telescopus', 'Notropis texanus', 'Notropis volucellus', 'Notropis wickliffi',

    'Noturus exilis', 'Noturus flavus', 'Noturus gyrinus', 'Noturus miurus',

    'Noturus nocturnus', 'Phenacobius mirabilis'

]



print('Generating phylogeny files...')

phylogeny = Phylogeny(

    filePath='/users/PZS1151/llies/phylonn/dataset',

    node_ids=species,

    verbose=True

)

print('Done. Files saved to /users/PZS1151/llies/phylonn/dataset')

