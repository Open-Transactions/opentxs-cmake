# Copyright (c) 2020-2022 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

macro(set_out_of_source_build)
  if(${CMAKE_CURRENT_SOURCE_DIR}
     STREQUAL
     ${CMAKE_CURRENT_BINARY_DIR}
  )
    message(
      FATAL_ERROR
        "CMake generation is not allowed within the source directory!
Remove the CMakeCache.txt file and try again from another folder, e.g.:

   rm CMakeCache.txt
   mkdir build
   cd build
   cmake ..
"
    )
  endif()
endmacro()
