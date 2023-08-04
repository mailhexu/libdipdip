project('dipdip', 'c',
  version : '0.1',
  license: 'GPLv3',
  default_options : ['warning_level=3'])

add_languages('fortran' )

incdir=include_directories('include')

#add_project_arguments('-DFOO=bar', language='c')

sources=[]

subdir('src')

#executable('', sources, include_directories : incdir, link_args: '-Wl,--lblas')
library('libdipdip', sources, include_directories : incdir, link_args: '-Wl,--lblas')


