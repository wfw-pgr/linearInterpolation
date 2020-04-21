program main
  use lInterp1DMod
  implicit none
  integer         , parameter :: nData = 11
  integer         , parameter :: nIntp = 201
  double precision, parameter :: xMin  = 0.0d0
  double precision, parameter :: xMax  = 2.0d0
  integer                     :: iData
  double precision            :: dx
  integer         , parameter :: force_to_ = 1
  double precision, allocatable :: xa(:), fa(:), xp(:), fp(:)
  

  ! ------------------------------------------------------ !
  ! --- [1] preparation                                --- !
  ! ------------------------------------------------------ !
  allocate( xa(nData), fa(nData), xp(nIntp), fp(nIntp) )
  xa(:) = 0.d0
  fa(:) = 0.d0
  xp(:) = 0.d0
  fp(:) = 0.d0

  ! ------------------------------------------------------ !
  ! --- [2] generate sample data                       --- !
  ! ------------------------------------------------------ !
  !  -- [2-1] xa                                       --  !
  dx = ( xMax-xMin ) / dble( nData-1 )
  do iData=1, nData
     xa(iData) = dx*dble(iData-1) + xMin
  enddo
  !  -- [2-2] xp                                       --  !
  dx = ( xMax-xMin ) / dble( nIntp-1 )
  do iData=1, nIntp
     xp(iData) = dx*dble(iData-1) + xMin
  enddo
  !  -- [2-3] fa                                       --  !
  do iData=1, nData
     fa(iData) = xa(iData)**2
  enddo
  !  -- [2-4] fp                                       --  !
  do iData=1, nIntp
     fp(iData) = 0.d0
  enddo
  
  ! ------------------------------------------------------ !
  ! --- [3] interpolation                              --- !
  ! ------------------------------------------------------ !
  call linearInterp1D( xa, fa, xp, fp, nData, nIntp, force_to_ )

  ! ------------------------------------------------------ !
  ! --- [4] save Data                                  --- !
  ! ------------------------------------------------------ !
  
  open( 50, file="dat/xa_fa.dat", status="replace", form="formatted" )
  do iData=1, nData
     write(50,*) xa(iData), fa(iData)
  enddo
  close(50)
  open( 50, file="dat/xp_fp.dat", status="replace", form="formatted" )
  do iData=1, nIntp
     write(50,*) xp(iData), fp(iData)
  enddo
  close(50)
  
  
end program main
