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
  write(10,*)
  write(11,*)
  write(12,*)
  write(13,*)
  close(10);close(11);close(12);close(13)
