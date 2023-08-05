cmake_minimum_required(VERSION 3.1)
project(dipdip)
enable_language(Fortran)


set(dipdip_cmake_dir "${CMAKE_CURRENT_SOURCE_DIR}/CMake")
list(INSERT CMAKE_MODULE_PATH 0 "${dipdip_cmake_dir}")

# MPI
find_package(MPI REQUIRED)
include_directories(${MPI_INCLUDE_PATH})

if(NOT MPI_Fortran_FOUND)
    message(FATAL_ERROR "Could not find Fortran MPI.  Please set MPI_Fortran_COMPILER to point to the mpifort wrapper.")
endif()

include_directories(${MPI_Fortran_INCLUDE_PATH})
add_compile_options(${MPI_Fortran_COMPILE_FLAGS})

add_definitions(${MPI_Fortran_COMPILE_FLAGS})
link_directories(${MPI_Fortran_LIBRARIES})



# blas/lapack
find_package(BLAS)
find_package(LAPACK)
if(LAPACK_FOUND AND BLAS_FOUND)
   set(lapackblas_libraries ${BLAS_LIBRARIES} ${LAPACK_LIBRARIES})
endif()

# netcdf
include(FindNetCDF)
set (NETCDF_F90 "YES")
find_package (NetCDF REQUIRED)
include_directories(${NETCDF_INCLUDES})


# binaries
set(CMAKE_Fortran_MODULE_DIRECTORY ${PROJECT_BINARY_DIR}/mods)

include_directories(include)

file(GLOB sourcefile
    "include/*.h"
    "src/abinit/*.F90"
    "src/abinit/xmpi/*.F90"
    "src/abinit/xmpi/*.finc")
#target_include_directories(dipdip PRIVATE "include")

#list(REMOVE_ITEM sourcefile
#    "${CMAKE_CURRENT_SOURCE_DIR}/src/unittest.F90"
#    "${CMAKE_CURRENT_SOURCE_DIR}/src/computeU.F90"
#)

set(CMAKE_Fortran_FLAGS "-fallow-argument-mismatch")

add_library(dipdip SHARED
    ${sourcefile}
    )

# wanntb
target_link_libraries(dipdip ${lapackblas_libraries} ${MPI_Fortran_LIBRARIES}  ${NETCDF_LIBRARIES_F90})

if(MPI_COMPILE_FLAGS)
  set_target_properties(dipdip PROPERTIES
      COMPILE_FLAGS "${MPI_Fortran_COMPILE_FLAGS}")
endif()

if(MPI_LINK_FLAGS)
  set_target_properties(dipdip PROPERTIES
      LINK_FLAGS "${MPI_Fortran_LINK_FLAGS}")
endif()

# libmultibinit
file(GLOB multibinit_sourcefile
	"src/multibinit/*.F90",
	"src/multibinit/*.c",
)
add_library(multibinit SHARED
	${multibinit_sourcefile}
)

target_link_libraries(multibinit dipdip ${lapackblas_libraries} ${MPI_Fortran_LIBRARIES}  ${NETCDF_LIBRARIES_F90})

if(MPI_COMPILE_FLAGS)
  set_target_properties(dipdip PROPERTIES
      COMPILE_FLAGS "${MPI_Fortran_COMPILE_FLAGS}")
endif()

if(MPI_LINK_FLAGS)
  set_target_properties(dipdip PROPERTIES
      LINK_FLAGS "${MPI_Fortran_LINK_FLAGS}")
endif()




# unit test
add_executable(testm
 src/main/main.F90
  )
#
target_link_libraries(testm dipdip ${lapackblas_libraries} ${NETCDF_LIBRARIES_F90} )
#
## computeU
#add_executable(computeU
# #${sourcefile}
# src/computeU.F90
# )
#
#target_link_libraries(computeU wanntb ${lapackblas_libraries}  ${NETCDF_LIBRARIES_F90} )
