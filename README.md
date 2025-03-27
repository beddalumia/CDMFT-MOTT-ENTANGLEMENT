# CDMFT-MOTT-ENTANGLEMENT
Lanczos/Arnoldi implementation of Cluster Dynamical
Mean-Field Theory, as used for the CDMFT/ED calculations
in https://arxiv.org/abs/2308.13706 [published as Phys. Rev. B **109**, 115104 (2024)].

This repository is a _frozen_ version of https://github.com/QcmPlab/CDMFT-LANC-ED,
with the aim of ensuring perfect reproducibility of the related paper. Since 2025,
the main development trunk of the code has moved to https://github.com/EDIpack/EDIpack2.0,
as the project is being merged to the EDIpack2 solver.

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
