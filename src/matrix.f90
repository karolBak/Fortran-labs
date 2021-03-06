#if !defined(_KIND)
#define _KIND 4
#endif

module matrix
    implicit none
contains

! ---- tridiagonal_solve ---------------------------
! Solves a tridiagonal system using simplified Gauss
! elimination algorithm.
!
!   [A] x [X] = [V]
! 
! A - tridiagonal matrix
! X - initially it is input V, then it becomes i
!     solution of the system
! N - size of the matrix
!
subroutine tridiagonal_solve (A,X,N) 
    implicit none

    real (kind=_KIND), intent(inout) :: A(:,:), X(:)
    integer (kind=4), intent(in) :: N

    real (kind=_KIND) :: multi
    integer (kind=4) :: i

    ! Finding normalized bidiagonal matrix
    X(1) = X(1) / A(1,2)
    A(1,3) = A(1,3) / A(1,2)

    do i = 2,N
        multi = A(i,2) - A(i,1) * A(i-1,3)
        A(i,3) = A(i,3) / multi
        X(i) = (X(i) - A(i,1) * X(i-1)) / multi
    end do

    ! Obtaining result using back substitution
    do i = N-1,1,-1
        X(i) = X(i) - A(i,3) * X(i+1)
    end do

end subroutine tridiagonal_solve

end module matrix

