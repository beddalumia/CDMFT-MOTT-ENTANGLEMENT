 subroutine ed_get_dens_lattice_1(yii,Nineq)
   integer                            :: Nineq
   real(8),dimension(Nineq,Nlat,Norb) :: yii
   yii=0d0    
   if(allocated(dens_ineq))then
      if(Nineq>size(dens_ineq,1)) stop "ed_get_dens error: required N_sites > evaluated N_sites"
      yii=dens_ineq
   end if
 end subroutine ed_get_dens_lattice_1

