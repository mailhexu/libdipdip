project('test_builds', 'c',
  version : '0.1',
  default_options : ['warning_level=3'])


#cython = find_program('cython3', required : false)
#if not cython.found()
#  error('MESON_SKIP_TEST: Cython3 not found.')
#endif


add_languages('fortran', 'cython')


# https://mesonbuild.com/Python-module.html
# requires atleast 0.46.0
py_mod = import('python')
py3 = py_mod.find_installation()
py3_dep = py3.dependency()

incdir_numpy = run_command(py3,
  ['-c', 'import os; os.chdir(".."); import numpy; print(numpy.get_include())'],
  check : true
).stdout().strip()

inc_np = include_directories(incdir_numpy)

py3.extension_module('fibby',
           'fibby.pyx',
           'fib1.F90',
           dependencies : py3_dep,
           install : true)
