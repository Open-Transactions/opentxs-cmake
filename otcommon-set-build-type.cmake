# Copyright (c) 2020-2022 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

macro(otcommon_set_build_type)
  if(CMAKE_BUILD_TYPE
     STREQUAL
     ""
  )
    set(CMAKE_BUILD_TYPE
        Release
        CACHE
          STRING
          "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel."
          FORCE
    )
  endif()
endmacro()
