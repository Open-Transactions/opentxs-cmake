# Copyright (c) 2019 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

function(print_build_details buildPedantic enableTests)
  message(STATUS "General -------------------------------------")
  message(STATUS "Project name:           ${PROJECT_NAME}")
  message(STATUS "Project version:        ${VERSION_STRING}")
  message(STATUS "CMake version:          ${CMAKE_VERSION}")
  message(STATUS "Build type:             ${CMAKE_BUILD_TYPE}")
  message(STATUS "System:                 ${CMAKE_SYSTEM}")
  message(STATUS "Processor:              ${CMAKE_SYSTEM_PROCESSOR}")
  message(STATUS "C++ Compiler ID:        ${CMAKE_CXX_COMPILER_ID}")
  message(STATUS "C++ Compiler:           ${CMAKE_CXX_COMPILER}")
  message(STATUS "C++ Flags:              ${CMAKE_CXX_FLAGS}")
  message(STATUS "C++ link flags:         ${CMAKE_CXX_LINK_FLAGS}")
  message(STATUS "C Compiler ID:          ${CMAKE_C_COMPILER_ID}")
  message(STATUS "C Compiler:             ${CMAKE_C_COMPILER}")
  message(STATUS "C Flags:                ${CMAKE_C_FLAGS}")
  message(STATUS "C link flags:           ${CMAKE_C_LINK_FLAGS}")
  message(STATUS "Verbose:                ${CMAKE_VERBOSE_MAKEFILE}")

  if(DEFINED buildPedantic)
    message(STATUS "Pedantic:               ${${buildPedantic}}")
  endif()

  if(DEFINED enableTests)
    message(STATUS "Testing:                ${${enableTests}}")
  endif()
endfunction()
