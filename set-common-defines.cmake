# Copyright (c) 2020 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

macro(set_common_defines)
  if(WIN32)
    if(NOT IDC_STATIC)
      add_definitions(-DIDC_STATIC=-1)
    endif()

    add_definitions(-DNOMINMAX)
    add_definitions(-D_UNICODE)
  endif()

  if(ANDROID)
    add_definitions(-DANDROID)
  endif()

  if(LIB_ANDROID_LOG)
    add_definitions(-DUSE_ANDROID_LOG)
  endif()
endmacro()
