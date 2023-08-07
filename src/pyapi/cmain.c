#include "fmod.h"
int main()
{
   double x;
   int a[3];
   x=0.3;
   cfunc2(x); 
   cfunc3(&x);
   a[0]=1;
   a[1]=3;
   a[2]=4;
   cfunc_array(a, 3);
	return 0;
}



