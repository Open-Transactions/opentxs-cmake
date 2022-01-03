# Copyright (c) 2020-2022 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

macro(update_git_submodules)
  find_program(GIT git NO_CMAKE_FIND_ROOT_PATH)

  if(GIT-NOTFOUND)
    message(FATAL_ERROR "git not found.")
  endif()

  execute_process(
    COMMAND ${GIT} "submodule" "update" "--init" "--recursive"
    WORKING_DIRECTORY ${${PROJECT_NAME}_SOURCE_DIR}
  )
endmacro()
