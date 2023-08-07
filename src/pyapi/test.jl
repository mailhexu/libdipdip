#!/usr/bin/env julia

#@ccall "libfmod.so".__fmod_MOD_func2(2.0::Cdouble)::Cvoid
@ccall "libfmod.so".cfunc2(2.0::Cdouble)::Cvoid
