# fibby.pyx
from numpy cimport ndarray
import ctypes
import numpy as np

cdef extern:
    void c_fib(double *a, int n)

def fib(double a, int n):
    #cdef ndarray[double, mode="c"] ret = np.zeros(n, dtype=double)
    cdef ndarray[double, mode="c"] ret = np.zeros(n, dtype=double)
    c_fib(&ret,n)
    return ret
