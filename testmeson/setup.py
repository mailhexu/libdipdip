from numpy.distutils.core import Extension, setup
fibby = Extension(name = 'fib',
                  sources = ['fib1.F90'])
if __name__ == "__main__":
    setup(name = 'fib', ext_modules = [ fibby ])
