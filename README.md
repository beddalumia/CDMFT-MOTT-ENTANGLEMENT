# CDMFT-MOTT-ENTANGLEMENT
Lanczos/Arnoldi implementation of Cluster Dynamical
Mean-Field Theory, as used for the CDMFT/ED calculations
published in [Phys. Rev. B **109**, 115104 (2024)](https://doi.org/10.1103/PhysRevB.109.115104) [free to read at [arXiv:2308.13706](https://arxiv.org/abs/2308.13706)].

This repository is a _frozen_ version of https://github.com/QcmPlab/CDMFT-LANC-ED,
with the aim of ensuring perfect reproducibility of the related paper. Some of the
features (i.e. the tracing facilities, to evaluate reduced density matrices) have 
been included in the latest version of [EDIpack](https://github.com/EDIpack/EDIpack),
published in [SciPost Physics Codebases 58](https://scipost.org/10.21468/SciPostPhysCodeb.58).

The `src` directory contains the Fortran source code for
the cluster ED solver and the self-consistent DMFT loop
for the two-dimensional Hubbard model.
The `lib` directory embeds a set of frozen external
libraries, necessary for compiling the CDMFT/ED code.

The required installation order is:
- [SciFortran](lib/scifortran) [`lib/scifortran`]
- [DMFTtools](lib/dmft-tools) [`lib/dmft-tools`]
- [CDMFT/ED](src/cdmft-ed) [`src/cdmft-ed`]

Detailed instruction for the three codes are provided in
the relative subdirectories, as README files.

----

When using this code in a scientific publication, please cite both the codebase and the related paper:
```
@software{cdmft-mott-entanglement,
  author       = {Gabriele Bellomia},
  title        = {CDMFT-MOTT-ENTANGLEMENT},
  month        = feb,
  year         = 2024,
  publisher    = {Zenodo},
  version      = {PhysRevB.109.115104},
  doi          = {10.5281/zenodo.10628156},
  url          = {https://doi.org/10.5281/zenodo.10628156}
}

@article{PhysRevB.109.115104,
  title = {Quasilocal entanglement across the {Mott-Hubbard} transition},
  author = {Bellomia, Gabriele and Mejuto-Zaera, Carlos and Capone, Massimo and Amaricci, Adriano},
  journal = {Phys. Rev. B},
  volume = {109},
  issue = {11},
  pages = {115104},
  numpages = {13},
  year = {2024},
  month = {Mar},
  publisher = {American Physical Society},
  doi = {10.1103/PhysRevB.109.115104},
  url = {https://link.aps.org/doi/10.1103/PhysRevB.109.115104}
}
```
