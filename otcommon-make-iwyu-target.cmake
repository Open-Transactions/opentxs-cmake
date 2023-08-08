# Copyright (c) 2020-2022 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

function(otcommon_make_iwyu_target)
  find_program(otcommon_iwyu_path NAMES include-what-you-use REQUIRED)
  find_program(otcommon_fix_includes_path NAMES fix_includes.py REQUIRED)

  set(OTCOMMON_IWYU_ARGS
      "${otcommon_iwyu_path}"
      "-Xiwyu"
      "--mapping_file=${${PROJECT_NAME}_SOURCE_DIR}/iwyu.imp"
  )
  set(CMAKE_C_INCLUDE_WHAT_YOU_USE
      "${OTCOMMON_IWYU_ARGS}"
      PARENT_SCOPE
  )
  set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE
      "${OTCOMMON_IWYU_ARGS}"
      PARENT_SCOPE
  )

  set(OTCOMMON_FIX_INCLUDES_ARGS
      "${otcommon_fix_includes_path}"
      "-b"
      "--nocomments"
      "--nosafe_headers"
      "--reorder"
      "<"
      "${${PROJECT_NAME}_BINARY_DIR}/iwyu.txt"
  )
  add_custom_target(
    fix_includes
    COMMAND "${OTCOMMON_FIX_INCLUDES_ARGS}"
    WORKING_DIRECTORY "${${PROJECT_NAME}_SOURCE_DIR}"
    COMMAND_EXPAND_LISTS
  )
  set(${PROJECT_NAME}_FIX_INCLUDES_ARGS
      "${OTCOMMON_FIX_INCLUDES_ARGS}"
      PARENT_SCOPE
  )
endfunction()
