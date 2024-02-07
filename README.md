# MIproject
A collection of programs and scripts to solve and analyze the Mott-Hubbard transition in a variety of dynamical mean-field settings.

## Requirements
The project relies on several inter-dependent[^1] external libraries:

[^1]: More specifically: DMFT-tools depends on SciFortran, DMFT-ED and EDlattice depend on SciFortran, CDMFT-ED depends on both SciFortran and DMFT-tools. DMFT-LAB strictly depends on nothing but a working installation of MATLAB / GNU OCTAVE, but its whole purpose is to manage the runtime and post-processing workflows for DMFT-ED and CDMFT-ED executables so, in a sense, it depends on eveything.

- [SciFortran](lib/scifor)
- [DMFT-tools](lib/dmft-tools)
- [DMFT-ED](lib/dmft-ed)
- [CDMFT-ED](lib/cdmft-ed)
- [EDlattice](lib/edlat)
- [DMFT-LAB](lib/dmft-lab)

These dependencies are [embedded](./lib/) through [git submodule tools](https://git-scm.com/book/en/v2/Git-Tools-Submodules). To download the project with all the intended versions of such libraries, just run:

```
git clone --recursive https://github.com/bellomia/MIproject.git MIproject
```

To pull upstream changes < of one specific module > you can run:

```
git submodule update --remote --merge <submodule-name>
```

**Warning:** The build and installation of the libraries is not automatized (yet?), thus you will need to enter each submodule directory and follow the provided instructions. All the upstream requirements have to be met, even the "optional" ones (e.g. MPI related stuff).
