# Copyright (c) 2020-2022 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

function(otcommon_define_signed_overflow target_name)
  if(MSVC)
    # TODO target_compile_options(${target_name} PRIVATE "/d1UndefIntOverflow-")
  else()
    target_compile_options(${target_name} PRIVATE "-fwrapv")
  endif()
endfunction()
