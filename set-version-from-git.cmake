# Copyright (c) 2020 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

macro(set_version_from_git)
  find_program(GIT git NO_CMAKE_FIND_ROOT_PATH)

  if(GIT-NOTFOUND)
    message(FATAL_ERROR "git not found.")
  endif()

  execute_process(
    COMMAND ${GIT} "describe"
    OUTPUT_VARIABLE ${PROJECT_NAME}_GIT_VERSION
    WORKING_DIRECTORY ${${PROJECT_NAME}_SOURCE_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  string(
    REGEX
    REPLACE
      "^([0-9]+)\\..*"
      "\\1"
      ${PROJECT_NAME}_VERSION_MAJOR
      "${${PROJECT_NAME}_GIT_VERSION}"
  )
  string(
    REGEX
    REPLACE
      "^${${PROJECT_NAME}_VERSION_MAJOR}\\.([0-9]+).*"
      "\\1"
      ${PROJECT_NAME}_VERSION_MINOR
      "${${PROJECT_NAME}_GIT_VERSION}"
  )
  string(
    REGEX
    REPLACE
      "^${${PROJECT_NAME}_VERSION_MAJOR}\\.${${PROJECT_NAME}_VERSION_MINOR}\\.([0-9]+).*"
      "\\1"
      ${PROJECT_NAME}_VERSION_PATCH
      "${${PROJECT_NAME}_GIT_VERSION}"
  )
  string(
    REGEX
    REPLACE
      "^${${PROJECT_NAME}_VERSION_MAJOR}\\.${${PROJECT_NAME}_VERSION_MINOR}\\.${${PROJECT_NAME}_VERSION_PATCH}-([0-9]+)-.*"
      "\\1"
      ${PROJECT_NAME}_VERSION_NEW_COMMITS
      "${${PROJECT_NAME}_GIT_VERSION}"
  )
  string(
    REGEX
    REPLACE
      "^${${PROJECT_NAME}_VERSION_MAJOR}\\.${${PROJECT_NAME}_VERSION_MINOR}\\.${${PROJECT_NAME}_VERSION_PATCH}-${${PROJECT_NAME}_VERSION_NEW_COMMITS}-(.*)"
      "\\1"
      ${PROJECT_NAME}_VERSION_SHA1
      "${${PROJECT_NAME}_GIT_VERSION}"
  )
  if("${${PROJECT_NAME}_VERSION_NEW_COMMITS}" STREQUAL
     "${${PROJECT_NAME}_GIT_VERSION}"
  )
    set(${PROJECT_NAME}_VERSION_STRING
        "${${PROJECT_NAME}_VERSION_MAJOR}.${${PROJECT_NAME}_VERSION_MINOR}.${${PROJECT_NAME}_VERSION_PATCH}"
    )
    set(${PROJECT_NAME}_VERSION_NEW_COMMITS "")
    set(${PROJECT_NAME}_VERSION_SHA1 "")
  else()
    set(${PROJECT_NAME}_VERSION_STRING
        "${${PROJECT_NAME}_VERSION_MAJOR}.${${PROJECT_NAME}_VERSION_MINOR}.${${PROJECT_NAME}_VERSION_PATCH}-${${PROJECT_NAME}_VERSION_NEW_COMMITS}-${${PROJECT_NAME}_VERSION_SHA1}"
    )
  endif()
  if("${${PROJECT_NAME}_VERSION_STRING}" STREQUAL "..")
    message(FATAL_ERROR "Version string missing.")
  endif()
endmacro()
