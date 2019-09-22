# Try to find the LMDB librairies
# LMDB_FOUND - system has LMDB lib
# LMDB_INCLUDE_DIR - the LMDB include directory
# LMDB_LIBRARIES - Libraries needed to use LMDB

if(LMDB_INCLUDE_DIR AND LMDB_LIBRARIES)
  # Already in cache, be silent
  set(LMDB_FIND_QUIETLY TRUE)
endif(LMDB_INCLUDE_DIR AND LMDB_LIBRARIES)

find_path(LMDB_INCLUDE_DIR NAMES lmdb.h)
find_library(LMDB_LIBRARIES NAMES lmdb liblmdb)
message(STATUS "LMDB libs: " ${LMDB_LIBRARIES})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  LMDB
  DEFAULT_MSG
  LMDB_INCLUDE_DIR
  LMDB_LIBRARIES
)

mark_as_advanced(LMDB_INCLUDE_DIR LMDB_LIBRARIES)
