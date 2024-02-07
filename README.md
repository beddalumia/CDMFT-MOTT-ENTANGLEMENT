# CDMFT-MOTT-ENTANGLEMENT
Lanczos/Arnoldi implementation of Cluster Dynamical
Mean-Field Theory, as used for the CDMFT/ED calculations
in https://arxiv.org/abs/2308.13706.
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