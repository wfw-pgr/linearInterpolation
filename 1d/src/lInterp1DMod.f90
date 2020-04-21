module lInterp1DMod
contains

  ! ====================================================== !
  ! === linear Interpolation for 1D profile            === !
  ! ====================================================== !
  subroutine linearInterp1D( xa, fa, xp, fp, nData, nIntp, force_to_ )
    implicit none
    integer         , intent(in)  :: nData, nIntp
    double precision, intent(in)  :: xa(nData), fa(nData)
    double precision, intent(in)  :: xp(nData)
    double precision, intent(out) :: fp(nData)
    integer         , intent(in)  :: force_to_
    integer                       :: ik, is, iIni, iFin, iMid
    double precision              :: dxInv, p1, p2, hxp
    
    iMid = int( nData / 2 )
    do ik=1, nIntp

       hxp = xp(ik)
       
       ! ------------------------------------------------------ !
       ! --- [1] boundary value exceptions                  --- !
       ! ------------------------------------------------------ !
       !  -- out-of-range exception :: xp < min(xa)         --  !
       if ( hxp.lt.xa(    1) ) then
          if ( force_to_.eq.1 ) then
             hxp = xa(1)
          else
             write(6,*) "xp is out of range :: ik = ", ik, " xp(ik) = ", hxp
             write(6,*) "             range :: xa(1) = ", xa(1), ", xa(nData) = ", xa(nData)
             stop
          endif
       endif
       !  -- out-of-range exception :: xp > max(xa)         --  !
       if ( hxp.gt.xa(nData) ) then
          if ( force_to_.eq.1 ) then
             hxp = xa(nData)
          else
             write(6,*) "xp is out of range :: ik = ", ik, " xp(ik) = ", hxp
             write(6,*) "             range :: xa(1) = ", xa(1), ", xa(nData) = ", xa(nData)
             stop
          endif
       endif
       !  -- exact boundary value case ::                   --  !
       if ( hxp.eq.xa(nData) ) then
          fp(ik) = fa(nData)
          exit
       endif
       ! ------------------------------------------------------ !
       ! --- [2] search section to be interpolated          --- !
       ! ------------------------------------------------------ !
       !  --  initiarl search position                      --  !
       if ( hxp.ge.xa(iMid) ) then
          iIni = iMid
          iFin = nData
       else
          iIni = 1
          iFin = iMid-1
       endif
       !  --  search & interpolate                          --  !
       do is=iIni, iFin
          if ( ( hxp.ge.xa(is) ).and.( hxp.lt.xa(is+1) ) ) then
             dxInv  = 1.d0 / ( xa(is+1) - xa(is) )
             p1     = ( xa(is+1) - hxp    ) * dxInv
             p2     = ( hxp      - xa(is) ) * dxInv
             fp(ik) = p1*fa(is) + p2*fa(is+1)
             exit
          endif
       enddo
       
    enddo
    
    return
  end subroutine linearInterp1D
  
end module lInterp1DMod
