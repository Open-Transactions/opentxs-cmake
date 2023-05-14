# Copyright (c) 2020-2022 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

function(otcommon_print_target_compiler_flags target_name)
  get_target_property(
    TARGET_COMPILE_OPTIONS
    ${target_name}
    COMPILE_OPTIONS
  )
  message(STATUS "Compile options for target ${target_name}:")

  foreach(COMPILE_OPTION ${TARGET_COMPILE_OPTIONS})
    message(STATUS "    ${COMPILE_OPTION}")
  endforeach()
endfunction()
