include(FindPkgConfig)
pkg_check_modules(PC_ZMQ "libzmq")

find_path(ZMQ_INCLUDE_DIRS NAMES zmq.h HINTS ${PC_ZMQ_INCLUDE_DIRS})

find_library(ZMQ_LIBRARIES NAMES zmq HINTS ${PC_ZMQ_LIBRARY_DIRS})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  ZMQ
  DEFAULT_MSG
  ZMQ_LIBRARIES
  ZMQ_INCLUDE_DIRS
)
mark_as_advanced(ZMQ_LIBRARIES ZMQ_INCLUDE_DIRS)
