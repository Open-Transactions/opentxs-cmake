# Copyright (c) 2019 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

macro(hide_symbols macro_name)
  set(CMAKE_CXX_VISIBILITY_PRESET hidden)
  set(CMAKE_VISIBILITY_INLINES_HIDDEN YES)

  if(WIN32)
    add_definitions("-D${macro_name}=__declspec(dllexport)")
  else()
    add_definitions("-D${macro_name}=__attribute__((visibility(\"default\")))")
  endif()
endmacro()
