# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
Findsecp256k1
-------

Finds the secp256k1 library.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``unofficial::secp256k1``
  The secp256k1 library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``UNOFFICIAL-SECP256K1_FOUND``
  True if the system has the secp256k1 library.
``SECP256K1_VERSION``
  The version of the secp256k1 library which was found.
``SECP256K1_INCLUDE_DIRS``
  Include directories needed to use secp256k1.
``SECP256K1_LIBRARIES``
  Libraries needed to link to secp256k1.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``SECP256K1_INCLUDE_DIR``
  The directory containing ``secp256k1.h``.
``SECP256K1_LIBRARY``
  The path to the secp256k1 library.

#]=======================================================================]

find_package(PkgConfig QUIET)

if(PkgConfig_FOUND)
  pkg_check_modules(
    PC_secp256k1
    QUIET
    "libsecp256k1"
  )

  if(NOT PC_SECP256K1_FOUND)
    pkg_check_modules(
      PC_secp256k1
      QUIET
      "secp256k1"
    )
  endif(NOT PC_SECP256K1_FOUND)
endif()

find_path(
  SECP256K1_INCLUDE_DIR
  NAMES secp256k1.h
  PATHS ${PC_secp256k1_INCLUDE_DIRS}
)
find_library(
  SECP256K1_LIBRARY
  NAMES libsecp256k1 secp256k1
  PATHS ${PC_secp256k1_LIBRARY_DIRS}
)

set(SECP256K1_VERSION ${PC_secp256k1_VERSION})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  ${CMAKE_FIND_PACKAGE_NAME}
  FOUND_VAR UNOFFICIAL-SECP256K1_FOUND
  REQUIRED_VARS SECP256K1_LIBRARY SECP256K1_INCLUDE_DIR
  VERSION_VAR SECP256K1_VERSION
)

if(UNOFFICIAL-SECP256K1_FOUND)
  set(SECP256K1_LIBRARIES ${SECP256K1_LIBRARY})
  set(SECP256K1_INCLUDE_DIRS ${SECP256K1_INCLUDE_DIR})
  set(SECP256K1_DEFINITIONS ${PC_secp256k1_CFLAGS_OTHER})
endif()

if(UNOFFICIAL-SECP256K1_FOUND
   AND NOT
       TARGET
       unofficial::secp256k1
)
  add_library(
    unofficial::secp256k1
    UNKNOWN
    IMPORTED
  )
  set_target_properties(
    unofficial::secp256k1
    PROPERTIES
      IMPORTED_LOCATION "${SECP256K1_LIBRARY}"
      INTERFACE_COMPILE_OPTIONS "${PC_secp256k1_CFLAGS_OTHER}"
      INTERFACE_INCLUDE_DIRECTORIES "${SECP256K1_INCLUDE_DIR}"
  )
endif()

mark_as_advanced(SECP256K1_INCLUDE_DIR SECP256K1_LIBRARY)
