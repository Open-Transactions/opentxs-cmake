# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindSodium
-------

Finds the Sodium library.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``unofficial-sodium::sodium``
  The Sodium library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``UNOFFICIAL-SODIUM_FOUND``
  True if the system has the Sodium library.
``SODIUM_VERSION``
  The version of the Sodium library which was found.
``SODIUM_INCLUDE_DIRS``
  Include directories needed to use Sodium.
``SODIUM_LIBRARIES``
  Libraries needed to link to Sodium.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``SODIUM_INCLUDE_DIR``
  The directory containing ``sodium.h``.
``SODIUM_LIBRARY``
  The path to the Sodium library.

#]=======================================================================]

find_package(PkgConfig QUIET)

if(PkgConfig_FOUND)
  pkg_check_modules(
    PC_Sodium
    QUIET
    "libsodium"
  )

  if(NOT PC_Sodium_FOUND)
    pkg_check_modules(
      PC_Sodium
      QUIET
      "sodium"
    )
  endif(NOT PC_Sodium_FOUND)
endif()

find_path(
  SODIUM_INCLUDE_DIR
  NAMES sodium.h
  PATHS ${PC_Sodium_INCLUDE_DIRS}
)
find_library(
  SODIUM_LIBRARY
  NAMES libsodium sodium
  PATHS ${PC_Sodium_LIBRARY_DIRS}
)

set(SODIUM_VERSION ${PC_Sodium_VERSION})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  ${CMAKE_FIND_PACKAGE_NAME}
  FOUND_VAR UNOFFICIAL-SODIUM_FOUND
  REQUIRED_VARS SODIUM_LIBRARY SODIUM_INCLUDE_DIR
  VERSION_VAR SODIUM_VERSION
)

if(UNOFFICIAL-SODIUM_FOUND)
  set(SODIUM_LIBRARIES ${SODIUM_LIBRARY})
  set(SODIUM_INCLUDE_DIRS ${SODIUM_INCLUDE_DIR})
  set(SODIUM_DEFINITIONS ${PC_Sodium_CFLAGS_OTHER})
endif()

if(UNOFFICIAL-SODIUM_FOUND
   AND NOT
       TARGET
       unofficial-sodium::sodium
)
  add_library(
    unofficial-sodium::sodium
    UNKNOWN
    IMPORTED
  )
  set_target_properties(
    unofficial-sodium::sodium
    PROPERTIES
      IMPORTED_LOCATION "${SODIUM_LIBRARY}"
      INTERFACE_COMPILE_OPTIONS "${PC_Sodium_CFLAGS_OTHER}"
      INTERFACE_INCLUDE_DIRECTORIES "${SODIUM_INCLUDE_DIR}"
  )
endif()

mark_as_advanced(SODIUM_INCLUDE_DIR SODIUM_LIBRARY)
