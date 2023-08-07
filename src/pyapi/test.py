#!/usr/bin/env python3
from cffi import FFI
import numpy as np

def test():
    ffi = FFI()
    ffi.cdef("""
        void cfunc2(double x);
        void cfunc3(double *x);
        void cfunc_array(int x[], int n);
        void cfunc_alloc_array(int *x, int n);
        void cfunc_alloc_array_2d(int *x, int n);
        void *malloc(size_t n);
        void myfree(int*);
    """)
    C = ffi.dlopen("libfmod.so")   # load the C library
    a=1.5
    C.cfunc2(a)                # call a C function

    # call by ref
    b=ffi.new("double *")
    b[0]=1.5
    C.cfunc3(b)               
    
    # array
    a=ffi.new("int[]", [1,2,5])
    C.cfunc_array(a, 3)

    print("allocating array")
    aa=ffi.new("int*" )
    #aa=C.malloc(3)
    C.cfunc_alloc_array(aa, 3)
    #ffi.gc(aa, C.free)
    C.myfree(aa)

    a2d=ffi.new("int*" )
    #aa=C.malloc(3)
    C.cfunc_alloc_array(a2d, 3)
    #ffi.gc(aa, C.free)
    print(a2d)
    C.myfree(a2d)



if __name__ == "__main__":
    test()
