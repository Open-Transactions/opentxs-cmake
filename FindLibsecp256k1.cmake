# - Find Libsecp256k1
# Find the native libsecp256k1 includes and library.
# Once done this will define
#
#  LIBSECP256K1_INCLUDE_DIR    - where to find libsecp256k1 header files, etc.
#  LIBSECP256K1_LIBRARY        - List of libraries when using libsecp256k1.
#  LIBSECP256K1_FOUND          - True if libsecp256k1 found.
#

find_library(
  LIBSECP256K1_LIBRARY
  NAMES libsecp256k1 secp256k1
  HINTS ${LIBSECP256K1_ROOT_DIR}/lib
)
find_path(
  LIBSECP256K1_INCLUDE_DIR
  NAMES secp256k1.h
  HINTS ${LIBSECP256K1_ROOT_DIR}/include
)

# handle the QUIETLY and REQUIRED arguments and set LIBSECP256K1_FOUND to TRUE
# if all listed variables are TRUE
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  Libsecp256k1
  REQUIRED_VARS
  LIBSECP256K1_LIBRARY
  LIBSECP256K1_INCLUDE_DIR
)

mark_as_advanced(LIBSECP256K1_LIBRARY LIBSECP256K1_INCLUDE_DIR)
