# Copyright (c) 2019 The Open-Transactions developers
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
    OUTPUT_VARIABLE GIT_VERSION
    WORKING_DIRECTORY ${${PROJECT_NAME}_SOURCE_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  string(
    REGEX
    REPLACE
      "^([0-9]+)\\..*"
      "\\1"
      VERSION_MAJOR
      "${GIT_VERSION}"
  )
  string(
    REGEX
    REPLACE
      "^${VERSION_MAJOR}\\.([0-9]+).*"
      "\\1"
      VERSION_MINOR
      "${GIT_VERSION}"
  )
  string(
    REGEX
    REPLACE
      "^${VERSION_MAJOR}\\.${VERSION_MINOR}\\.([0-9]+).*"
      "\\1"
      VERSION_BUGFIX
      "${GIT_VERSION}"
  )
  string(
    REGEX
    REPLACE
      "^${VERSION_MAJOR}\\.${VERSION_MINOR}\\.${VERSION_BUGFIX}-([0-9]+)-.*"
      "\\1"
      VERSION_NEW_COMMITS
      "${GIT_VERSION}"
  )
  string(
    REGEX
    REPLACE
      "^${VERSION_MAJOR}\\.${VERSION_MINOR}\\.${VERSION_BUGFIX}-${VERSION_NEW_COMMITS}-(.*)"
      "\\1"
      VERSION_SHA1
      "${GIT_VERSION}"
  )
  if("${VERSION_NEW_COMMITS}" STREQUAL "${GIT_VERSION}")
    set(VERSION_STRING "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_BUGFIX}")
    set(VERSION_NEW_COMMITS "")
    set(VERSION_SHA1 "")
  else()
    set(
      VERSION_STRING
      "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_BUGFIX}-${VERSION_NEW_COMMITS}-${VERSION_SHA1}"
    )
  endif()
  if("${VERSION_STRING}" STREQUAL "..")
    message(FATAL_ERROR "Version string missing.")
  endif()
endmacro()
