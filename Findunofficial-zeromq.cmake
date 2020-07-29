# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindZeroMQ
-------

Finds the ZeroMQ library.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``libzmq``
  The ZeroMQ library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``UNOFFICIAL-ZEROMQ_FOUND``
  True if the system has the ZeroMQ library.
``ZMQ_VERSION``
  The version of the ZeroMQ library which was found.
``ZMQ_INCLUDE_DIRS``
  Include directories needed to use ZeroMQ.
``ZMQ_LIBRARIES``
  Libraries needed to link to ZeroMQ.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``ZMQ_INCLUDE_DIR``
  The directory containing ``zmq.h``.
``ZMQ_LIBRARY``
  The path to the ZeroMQ library.

#]=======================================================================]

find_package(PkgConfig)
pkg_check_modules(PC_ZeroMQ QUIET "libzmq")

if(NOT PC_ZeroMQ_FOUND)
  pkg_check_modules(PC_ZeroMQ QUIET "zmq")
endif(NOT PC_ZeroMQ_FOUND)

find_path(ZMQ_INCLUDE_DIR NAMES zmq.h PATHS ${PC_ZeroMQ_INCLUDE_DIRS})
find_library(ZMQ_LIBRARY NAMES libzmq zmq PATHS ${PC_ZeroMQ_LIBRARY_DIRS})

set(ZMQ_VERSION ${PC_ZeroMQ_VERSION})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  ${CMAKE_FIND_PACKAGE_NAME}
  FOUND_VAR
  UNOFFICIAL-ZEROMQ_FOUND
  REQUIRED_VARS
  ZMQ_LIBRARY
  ZMQ_INCLUDE_DIR
  VERSION_VAR
  ZMQ_VERSION
)

if(UNOFFICIAL-ZEROMQ_FOUND)
  set(ZMQ_LIBRARIES ${ZMQ_LIBRARY})
  set(ZMQ_INCLUDE_DIRS ${ZMQ_INCLUDE_DIR})
  set(ZMQ_DEFINITIONS ${PC_ZeroMQ_CFLAGS_OTHER})
endif()

if(UNOFFICIAL-ZEROMQ_FOUND AND NOT TARGET libzmq)
  add_library(libzmq UNKNOWN IMPORTED)
  set_target_properties(
    libzmq
    PROPERTIES
      IMPORTED_LOCATION
      "${ZMQ_LIBRARY}"
      INTERFACE_COMPILE_OPTIONS
      "${PC_ZeroMQ_CFLAGS_OTHER}"
      INTERFACE_INCLUDE_DIRECTORIES
      "${ZMQ_INCLUDE_DIR}"
  )
endif()

mark_as_advanced(ZMQ_INCLUDE_DIR ZMQ_LIBRARY)
