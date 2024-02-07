! ROUTINES TO searche a zero of a scalar function F(X)

function brentq(func,a,b,tol) result(fzero)
  interface
     function func(x)
       real(8),intent(in) :: x
       real(8)            :: func
     end function func
  end interface
  real(8),intent(in) :: a,b
  real(8),optional   :: tol
  real(8)            :: fzero    
  real(8)            :: tol_    
  tol_=epsilon(a);if(present(tol))tol_=tol
  fzero = zbrent(func,a,b,tol_)
end function brentq




function zbrent(func,x1,x2,tol)
  implicit none
  interface
     function func(x)
       implicit none
       real(8), intent(in) :: x
       real(8)             :: func
     end function func
  end interface
  real(8), intent(in) :: x1,x2,tol
  real(8)             :: zbrent
  integer, parameter  :: itmax=100
  real(8), parameter  :: eps=epsilon(x1)
  integer             :: iter
  real(8)             :: a,b,c,d,e,fa,fb,fc,p,q,r,s,tol1,xm
  a=x1       ; b=x2
  fa=func(a) ; fb=func(b)
  if ((fa > 0.d0 .AND. fb > 0.d0) .OR. (fa < 0.d0 .AND. fb < 0.d0))then
     write(*,"(A)")'ROOT MUST BE BRACKETED FOR ZBRENT'
     stop
  endif
  c=b ; fc=fb
  do iter=1,itmax
     if ((fb > 0.d0 .AND. fc > 0.d0) .OR. (fb < 0.d0 .AND. fc < 0.d0)) then
        c=a
        fc=fa
        d=b-a
        e=d
     end if
     if (abs(fc) < abs(fb)) then
        a=b
        b=c
        c=a
        fa=fb
        fb=fc
        fc=fa
     end if
     tol1=2.d0*eps*abs(b)+0.5d0*tol
     xm=0.5d0*(c-b)
     if (abs(xm) <= tol1 .or. fb == 0.d0) then
        zbrent=b
        return
     end if
     !
     if (abs(e) >= tol1 .AND. abs(fa) > abs(fb)) then
        s=fb/fa
        if (a == c) then
           p=2.d0*xm*s
           q=1.d0-s
        else
           q=fa/fc
           r=fb/fc
           p=s*(2.d0*xm*q*(q-r)-(b-a)*(r-1.d0))
           q=(q-1.d0)*(r-1.d0)*(s-1.d0)
        end if
        if (p > 0.d0) q=-q
        p=abs(p)
        if (2.d0*p  <  min(3.d0*xm*q-abs(tol1*q),abs(e*q))) then
           e=d
           d=p/q
        else
           d=xm
           e=d
        end if
     else
        d=xm
        e=d
     end if
     a=b
     fa=fb
     b=b+merge(d,sign(tol1,xm), abs(d) > tol1 )
     fb=func(b)
  end do
  write(*,"(A)")'zbrent: exceeded maximum iterations'
  zbrent=b
end function zbrent




! Find root to equation f(x)=0 on [x1,x2] interval
! flag  - indicator of success
!         >0 - a single root found, flag=number of iterations
!          0 - no solutions for the bisectional method
!         <0 - not a root but singularity, flag=number of iterations
!
subroutine bisect(f,x1,x2,eps,niter,flag)
  implicit none
  interface                                                             
     function f(x)                                                   
       real(8) :: x
       real(8) :: f
     end function f
  end interface
  real(8)          :: x1, x2
  real(8),optional :: eps
  integer,optional :: Niter
  integer,optional :: flag
  real(8)          :: Root
  real(8)          :: eps_
  integer          :: Niter_
  real(8)          :: a, b, c
  integer          :: iter
  !
  eps_=1d-9;if(present(eps))eps_=eps
  Niter_=200;if(present(Niter))Niter_=Niter
  if(f(x1)*f(x2)>0.0) then
     flag = 0
     return
  end if
  a=x1
  b=x2
  do iter=1,Niter_
     c=(b+a)/2d0
     if(f(a)*f(c) <= 0d0) then
        b = c
     else
        a = c
     end if
     if(abs(b-a) <= eps_) exit  
  end do
  root=(b+a)/2.0
  !check if it is a root or singularity
  if(present(flag))then
     if (abs(f(root)) < 1d0) then
        flag =  iter
     else
        flag = -iter
     end if
  endif
  x1=root
  x2=root
end subroutine bisect


!    FZERO searches for a zero of a function F(X) between
!    the given values B and C until the width of the interval
!    (B,C) has collapsed to within a tolerance specified by
!    the stopping criterion, abs ( B - C ) <= 2 * ( RW * abs ( B ) + AE ).
!    The method used is an efficient combination of bisection
!    and the secant rule.
subroutine fzero(f,b,c,iflag,rguess,tol_rel,tol_abs)
  !
  !    Input, real ( kind = 8 ) R, a (better) guess of a zero of F which could
  !    help in speeding up convergence.  If F(B) and F(R) have opposite signs, 
  !    a root will be found in the interval (B,R); if not, but F(R) and F(C) 
  !    have opposite signs, a root will be found in the interval (R,C); 
  !    otherwise, the interval (B,C) will be searched for a possible root.
  !    When no better guess is known, it is recommended that R be set to B or C;
  !    because if R is not interior to the interval (B,C), it will be ignored.
  !
  !    Input, real ( kind = 8 ) RE, the relative error used for RW in the 
  !    stopping criterion.  If the input RE is less than machine precision,
  !    then RW is set to approximately machine precision.
  !
  !    Input, real ( kind = 8 ) AE, the absolute error used in the stopping
  !    criterion.  If the given interval (B,C) contains the origin, then a
  !    nonzero value should be chosen for AE.
  !
  !    Output, integer IFLAG, a status code.  The user must check IFLAG 
  !    after each call.  Control returns to the user in all cases.
  !
  !    1, B is within the requested tolerance of a zero.
  !      the interval (b,c) collapsed to the requested
  !      tolerance, the function changes sign in (b,c), and
  !      f(x) decreased in magnitude as (b,c) collapsed.
  !
  !    2, F(B) = 0.  however, the interval (b,c) may not have
  !      collapsed to the requested tolerance.
  !
  !    3, B may be near a singular point of f(x).
  !      the interval (b,c) collapsed to the requested tolerance and 
  !      the function changes sign in (b,c), but
  !      f(x) increased in magnitude as (b,c) collapsed,i.e.
  !      max ( ABS ( f(b in) ), ABS ( f(c in) ) ) < ABS ( f(b out) ).
  !
  !    4, no change in sign of f(x) was found although the
  !      interval (b,c) collapsed to the requested tolerance.
  !      the user must examine this case and decide whether
  !      b is near a local minimum of f(x), or B is near a
  !      zero of even multiplicity, or neither of these.
  !
  !    5, too many (more than 500) function evaluations used.
  !
  implicit none
  interface                                                             
     function f(x)                                                   
       real(8),intent(in) :: x
       real(8)            :: f
     end function f
  end interface
  real(8),optional :: rguess
  real(8),optional :: tol_rel
  real(8),optional :: tol_abs
  real(8) :: re
  real(8) :: ae
  real(8) :: a
  real(8) :: acbs
  real(8) :: acmb
  real(8) :: aw
  real(8) :: b
  real(8) :: c
  real(8) :: cmb
  real(8) :: er
  ! real(8) ::, external :: f
  real(8) :: fa
  real(8) :: fb
  real(8) :: fc
  real(8) :: fx
  real(8) :: fz
  integer :: ic
  integer :: iflag
  integer :: kount
  real(8) :: p
  real(8) :: q
  real(8) :: r
  real(8) :: rw
  real(8) :: t
  real(8) :: tol
  real(8) :: z
  !
  re=1d-12;if(present(tol_rel))re=tol_rel
  ae=1d-9;if(present(tol_abs))ae=tol_abs
  r = c;if(present(rguess))r=rguess
  !   
  er = 2.0D+00 * epsilon ( er )
  !
  !  Initialize.
  !
  z = r
  if ( r <= min ( b, c ) .or. max ( b, c ) <= r ) then
     z = c
  end if
  rw = max ( re, er )
  aw = max ( ae, 0.0D+00 )
  ic = 0
  t = z
  fz = f(t)
  fc = fz
  t = b
  fb = f(t)
  kount = 2
  if ( sign ( 1.0D+00, fz ) /= sign ( 1.0D+00, fb ) ) then
     c = z
  else if ( z /= c ) then
     t = c
     fc = f(t)
     kount = 3
     if ( sign ( 1.0D+00, fz ) /= sign ( 1.0D+00, fc ) ) then
        b = z
        fb = fz
     end if
  end if
  a = c
  fa = fc
  acbs = abs ( b - c )
  fx = max ( abs ( fb ), abs ( fc ) )
  do
     !
     !  Interchange
     !
     if ( abs ( fc ) < abs ( fb ) ) then
        a = b
        fa = fb
        b = c
        fb = fc
        c = a
        fc = fa
     end if
     cmb = 0.5D+00 * ( c - b )
     acmb = abs ( cmb )
     tol = rw * abs ( b ) + aw
     !
     !  Test stopping criterion and function count.
     !
     if ( acmb <= tol ) then
        exit
     end if
     if ( fb == 0.0D+00 ) then
        iflag = 2
        return
     end if
     if ( 500 <= kount ) then
        iflag = 5
        return
     end if
     !
     !  Calculate new iterate implicitly as b+p/q
     !  where we arrange 0 <= p.
     !  The implicit form is used to prevent overflow.
     !
     p = ( b - a ) * fb
     q = fa - fb
     if ( p < 0.0D+00 ) then
        p = -p
        q = -q
     end if
     !
     !  Update A and check for satisfactory reduction
     !  in the size of the bracketing interval.
     !  If not, perform bisection.
     !
5    continue
     a = b
     fa = fb
     ic = ic + 1
     if ( ic < 4 ) then
        go to 6
     end if
     if ( acbs <= 8.0D+00 * acmb ) then
        b = b + cmb
        go to 9
     end if
     ic = 0
     acbs = acmb
     !
     !  Test for too small a change
     !
6    continue
     if ( abs ( q ) * tol < p ) then
        go to 7
     end if
     !
     !  Increment by tolerance
     !
     b = b + sign ( tol, cmb )
     go to 9
     !
     !  Root ought to be between b and (c+b)/2.
     !
7    continue
     !
     !  Use the secant rule or bisection.
     !
     if ( p < cmb * q ) then
        b = b + p / q
     else
        b = b + cmb
     end if
     !
     !  Have completed computation for new iterate B.
     !
9    continue
     t = b
     fb = f(t)
     kount = kount + 1
     !
     !  Decide whether next step is interpolation or extrapolation.
     !
     if ( sign ( 1.0D+00, fb ) == sign ( 1.0D+00, fc ) ) then
        c = a
        fc = fa
     end if
  end do
  !
  !  Finished.  Process results for proper setting of IFlAG.
  !
  if ( sign ( 1.0D+00, fb ) == sign ( 1.0D+00, fc ) ) then
     iflag = 4
     return
  end if
  if ( fx < abs ( fb ) ) then
     iflag = 3
     return
  end if
  iflag = 1    
  return
end subroutine fzero





subroutine newton(f,xinit,eps,niter)
  interface
     function f(x)
       real(8) :: x
       real(8) :: f
     end function f
  end interface
  real(8), intent(inout) :: xinit
  real(8),optional       :: eps
  integer,optional       :: Niter
  real(8)                :: root
  real(8)                :: dh = 1d-4
  real(8)                :: fx1
  real(8)                :: fx2
  real(8)                :: fprime
  real(8)                :: x
  real(8)                :: xnew
  integer                :: i
  real(8)          :: eps_
  integer          :: Niter_
  !
  eps_=1d-9;if(present(eps))eps_=eps
  Niter_=200;if(present(Niter))Niter_=Niter
  !
  Root  = 0d0
  x = xinit
  do i = 1,niter_
     fx1    = f(x)
     fx2    = f(x+dh)
     fprime = (fx2 - fx1) / dh
     xnew   = x - fx1 / fprime
     if ( abs(xnew-x) <= eps_ ) then
        root  = xnew
        xinit = root
        exit
     endif
     x = xnew
  enddo
end subroutine newton
