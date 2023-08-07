module Fmod
use iso_c_binding
use iso_fortran_env

implicit none
private
public:: func1, func2

contains

subroutine func1(x, y, array1, array2, n1, n2, res) bind(c, name="cfunc1")
    real(c_double), value, intent(in) :: x, y
    real(c_double), allocatable,  intent(inout) :: array1(:), array2(:, :)
    integer(c_int), value, intent(in) :: n1, n2
    real(c_double), intent(out) :: res
    ALLOCATE(array1(n1))
    ALLOCATE(array2(n1, n2))
    array1(:) = x
    array2(:, :) = y
    res= sum(array1) + sum(array2)
end subroutine func1

subroutine  func2(x) bind(c, name="cfunc2")
    real(c_double), value, intent(in) :: x
    print *, "x = ", x
end subroutine func2

subroutine  func3(x) bind(c, name="cfunc3")
    real(c_double), intent(in) :: x
    print *, "x = ", x
end subroutine func3

subroutine func_array(x, n) bind(c, name="cfunc_array")
    integer(c_int), value, intent(in) :: n 
    integer(c_int),intent(inout) :: x(n)
    integer :: i
    do i =1, n
      print *, "x(i)=", x(i)
      x(i)=x(i)+1
    end do
end subroutine func_array
 

 subroutine func_alloc_array(x, n) bind(c, name="cfunc_alloc_array")
    integer(c_int), value, intent(in) :: n 
    integer(c_int), allocatable,intent(inout) :: x(:)
    integer :: i
    ALLOCATE(x(n))
    do i =1, n
      x(i)=i+1
      print *, "x(i): ", x(i)
    end do
    !DEALLOCATE(x)
end subroutine func_alloc_array

 subroutine func_alloc_array_2d(x, n) bind(c, name="cfunc_alloc_array_2d")
    integer(c_int), value, intent(in) :: n 
    integer(c_int), allocatable,intent(inout) :: x(:, :)
    integer :: i, j
    ALLOCATE(x(n,n))
    do i =1, n
       do j =1, n
          x(i, j)=i+j
          print *, "x(i, j): ", x(i, j)
        end do
    end do
end subroutine func_alloc_array_2d


subroutine myfree(x) bind(c, name="myfree")
  integer(c_int), allocatable :: x(:)
  deallocate(x)
end subroutine myfree


 
end module Fmod
