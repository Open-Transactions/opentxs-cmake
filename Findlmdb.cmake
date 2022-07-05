# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
Findlmdb
-------

Finds the lmdb library.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``lmdb``
  The lmdb library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``LMDB_FOUND``
  True if the system has the lmdb library.
``LMDB_VERSION``
  The version of the lmdb library which was found.
``LMDB_INCLUDE_DIRS``
  Include directories needed to use lmdb.
``LMDB_LIBRARIES``
  Libraries needed to link to lmdb.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``LMDB_INCLUDE_DIR``
  The directory containing ``lmdb.h``.
``LMDB_LIBRARY``
  The path to the lmdb library.

#]=======================================================================]

find_package(PkgConfig QUIET)

if(PkgConfig_FOUND)
  pkg_check_modules(
    PC_lmdb
    QUIET
    "liblmdb"
  )

  if(NOT PC_LMDB_FOUND)
    pkg_check_modules(
      PC_lmdb
      QUIET
      "lmdb"
    )
  endif(NOT PC_LMDB_FOUND)
endif()

find_path(
  LMDB_INCLUDE_DIR
  NAMES lmdb.h
  PATHS ${PC_lmdb_INCLUDE_DIRS}
)
find_library(
  LMDB_LIBRARY
  NAMES liblmdb lmdb
  PATHS ${PC_lmdb_LIBRARY_DIRS}
)

set(LMDB_VERSION ${PC_lmdb_VERSION})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  ${CMAKE_FIND_PACKAGE_NAME}
  FOUND_VAR LMDB_FOUND
  REQUIRED_VARS LMDB_LIBRARY LMDB_INCLUDE_DIR
  VERSION_VAR LMDB_VERSION
)

if(LMDB_FOUND)
  set(LMDB_LIBRARIES ${LMDB_LIBRARY})
  set(LMDB_INCLUDE_DIRS ${LMDB_INCLUDE_DIR})
  set(LMDB_DEFINITIONS ${PC_lmdb_CFLAGS_OTHER})
endif()

if(LMDB_FOUND
   AND NOT
       TARGET
       lmdb
)
  add_library(
    lmdb
    UNKNOWN
    IMPORTED
  )
  set_target_properties(
    lmdb
    PROPERTIES
      IMPORTED_LOCATION "${LMDB_LIBRARY}"
      INTERFACE_COMPILE_OPTIONS "${PC_lmdb_CFLAGS_OTHER}"
      INTERFACE_INCLUDE_DIRECTORIES "${LMDB_INCLUDE_DIR}"
  )
endif()

mark_as_advanced(LMDB_INCLUDE_DIR LMDB_LIBRARY)
