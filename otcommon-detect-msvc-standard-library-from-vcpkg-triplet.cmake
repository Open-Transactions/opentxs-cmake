# Copyright (c) 2020-2022 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

macro(otcommon_detect_msvc_standard_library_from_vcpkg_triplet)
  if(("${VCPKG_TARGET_TRIPLET}"
      STREQUAL
      "")
     AND ("${CMAKE_MSVC_RUNTIME_LIBRARY}"
          STREQUAL
          "")
  )
    message(
      FATAL_ERROR
        "You must set either CMAKE_MSVC_RUNTIME_LIBRARY or VCPKG_TARGET_TRIPLET so that the correct standard library can be determined"
    )
  endif()

  if(("${VCPKG_TARGET_TRIPLET}"
      STREQUAL
      "x64-windows")
     OR ("${VCPKG_TARGET_TRIPLET}"
         STREQUAL
         "x64-windows-static-md")
  )
    set(${PROJECT_NAME}_MSVC_RUNTIME_LIBRARY_SUFFIX "DLL")
  else()
    set(${PROJECT_NAME}_MSVC_RUNTIME_LIBRARY_SUFFIX "")
  endif()

  if("${CMAKE_BUILD_TYPE}"
     STREQUAL
     "Debug"
  )
    set(${PROJECT_NAME}_MSVC_RUNTIME_LIBRARY_DEBUG "Debug")
  else()
    set(${PROJECT_NAME}_MSVC_RUNTIME_LIBRARY_DEBUG "")
  endif()
endmacro()
