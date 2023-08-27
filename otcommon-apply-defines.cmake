# Copyright (c) 2020-2022 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

function(otcommon_apply_defines target_name)
  if(WIN32)
    if(NOT IDC_STATIC)
      target_compile_definitions(${target_name} PRIVATE IDC_STATIC=-1)
    endif()

    target_compile_definitions(
      ${target_name}
      PRIVATE
        NOMINMAX
        STRICT
        VC_EXTRALEAN
        WIN32_EXTRA_LEAN
        WIN32_LEAN_AND_MEAN
        _UNICODE
        _WIN32_WINNT=0x0601
    )
  endif()
endfunction()
