MODULE SF_IOTOOLS
  USE IOFILE
  USE IOPLOT
  USE IOREAD
  private

  public :: splot
  public :: splot3d
  public :: save_array
  !
  public :: sread
  public :: read_array
  !
  public :: set_store_size
  !
  public :: str
  public :: txtfy !obsolete
  public :: reg
  !
  public :: file_size
  public :: file_length
  public :: file_info
  public :: file_gzip           !data_store
  public :: file_gunzip         !data_open
  public :: file_targz
  public :: file_untargz
  !
  public :: newunit
  public :: free_unit
  public :: free_units
  !
  public :: create_dir
  !
  public :: get_filename
  public :: get_filepath
  !
  public :: print_matrix

END MODULE SF_IOTOOLS
