libfmod.so: fmod.o
	gfortran -shared fmod.o -o libfmod.so 

fmod.o: fmod.F90
	gfortran -fPIC -c fmod.F90 

cmain: cmain.c fmod.o
	gcc cmain.c fmod.o -o cmain -lgfortran

fmain: fmain.F90 fmod.o
	gfortran fmain.F90 fmod.o -o fmain

all: libfmod.so cmain fmain
