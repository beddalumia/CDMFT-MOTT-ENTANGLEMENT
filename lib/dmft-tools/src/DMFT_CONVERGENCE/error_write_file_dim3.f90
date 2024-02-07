  if(mpi_master)then
     !if(isnan(err))call abort("check_convergence: error is NaN. EXIT...")
     if(total_==1)then
        open(10,file=reg(file_)//".max",position="append")
        open(11,file=reg(file_)//".min",position="append")
        open(12,file=reg(file_),position="append")
        open(13,file=reg(file_)//".distribution")
     else
        write(label,"(I2)")index_
        open(10,file=reg(file_)//"."//reg(label)//".max",position="append")
        open(11,file=reg(file_)//"."//reg(label)//".min",position="append")
        open(12,file=reg(file_)//"."//reg(label),position="append")
        open(13,file=reg(file_)//"."//reg(label)//".distribution")
     endif
     write(10,"(I5,ES15.7)")check,error(1)
     write(11,"(I5,ES15.7)")check,error(2)
     write(12,"(I5,ES15.7)")check,err
     do i=1,Msize1
        do j=1,Msize2
           do k=1,Msize3
               write(13,"(ES15.7)")Verror(i,j,k)
           enddo
        enddo
     enddo
     close(10);close(11);close(12);close(13)
  endif
