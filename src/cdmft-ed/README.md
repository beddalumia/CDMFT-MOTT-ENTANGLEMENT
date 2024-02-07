# Cluster-DMFT Lanczos Exact Diagonalization

A Lanczos based solver for the Cluster Dynamical Mean-Field Theory using the `N_up:N_dw` implementation in the normal phase (plus long-range magnetic or charge order).  

The code is based on two external liberies:  

* [SciFortran](https://github.com/QcmPlab/SciFortran)  

* [DMFTtools](https://github.com/QcmPlab/DMFTtools)

The code structure is as follow:  

* The set of modules compile into a top layer named `CDMFT_ED.f90`  
* The actual implementation of the DMFT equations is case by case performed in a driver program, placed in the directory `drivers`. 
* In the driver code the user must include the `CDMFT_ED`, `SCIFOR` and `DMFT_TOOLS` modules and call the necessary procedures to solve the DMFT equations.

 The only two bath types implemented to date are the 'replica' and 'general' ones, in which the bath consists of multiple, noninteracting copies of the original interacting cluster, with different hybridization schemes: a unique $V$ for each replica in the former case, meaning that the i-th site in the cluster hybridizes with the j-th site in the replica, with an amplitude $V_{ij} = V\delta_{ij}$; a more general $V_{ij} = V_i \delta_{ij}$ for the latter.
 For both cases the bath can be initialized in two ways, through the unified `ed_set_Hbath` interface: one can directly pass the local hamiltonian of the cluster (going with strict semantics for 'replicas') or a symmetry-informed expansion in the form $H^\mathrm{bath} = \sum \lambda^\mathrm{sym}H^\mathrm{sym}$, where the $H^\mathrm{sym}$ terms are arrays isomorphic with $H^\mathrm{loc}$, describing a well defined symmetry of the model, and the $\lambda^\mathrm{sym}$ coefficients are contained in a `([Nineq])x[Nbath]x[Nsym]`-sized array, so to allow each replica to have a different expansion on the same unique basis. No control over the initial guess of the $V_{ij}$ values is given to the user, at the moment.   

 > An example, solving the Hubbard model on the square lattice, is contained in the file `drivers/cdn_hm_2dsquare.f90`.

## Compilation

The code relies on the `CMake` build environment. To build
a driver, assuming SciFortran and DMFTtools are built and
discoverable by `CMake`, follow the following steps:
```
mkdir build
cd build
cmake .. -DEXE=NAME_OF_DRIVER
make
```
--

***COPYRIGHT and FAIR USAGE***  
© 2024 Adriano Amaricci, Lorenzo Crippa, Gabriele Bellomia, Samuele Giuli, Massimo Capone.  
All rights reserved. 

The software is provided with no license, as such it is protected by copyright. The software is provided as it is and can be read and copied, in agreement with the Terms of Service of GITHUB. 
Use of the code is constrained to authors agreement.   

