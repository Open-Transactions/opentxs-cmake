# Copyright (c) 2020-2022 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

function(
  otcommon_print_build_details
  buildPedantic
  enableTests
)
  message(STATUS "General -------------------------------------")
  message(STATUS "Project name:             ${PROJECT_NAME}")
  message(STATUS "Project version:          ${${PROJECT_NAME}_VERSION_STRING}")
  message(STATUS "CMake version:            ${CMAKE_VERSION}")
  message(STATUS "Build type:               ${CMAKE_BUILD_TYPE}")
  message(STATUS "System:                   ${CMAKE_SYSTEM}")
  message(STATUS "Processor:                ${CMAKE_SYSTEM_PROCESSOR}")
  message(STATUS "C++ Compiler ID:          ${CMAKE_CXX_COMPILER_ID}")
  message(STATUS "C++ Compiler version:     ${CMAKE_CXX_COMPILER_VERSION}")
  message(STATUS "C++ Compiler path:        ${CMAKE_CXX_COMPILER}")
  message(STATUS "C++ Flags:                ${CMAKE_CXX_FLAGS}")
  message(STATUS "C Compiler ID:            ${CMAKE_C_COMPILER_ID}")
  message(STATUS "C Compiler version:       ${CMAKE_C_COMPILER_VERSION}")
  message(STATUS "C Compiler path:          ${CMAKE_C_COMPILER}")
  message(STATUS "C Flags:                  ${CMAKE_C_FLAGS}")
  message(STATUS "Shared linker flags:      ${CMAKE_SHARED_LINKER_FLAGS}")
  message(STATUS "Static linker flags:      ${CMAKE_STATIC_LINKER_FLAGS}")
  message(STATUS "Executable linker flags:  ${CMAKE_EXE_LINKER_FLAGS}")

  if(DEFINED CMAKE_MSVC_RUNTIME_LIBRARY)
    message(STATUS "C++ runtime library:      ${CMAKE_MSVC_RUNTIME_LIBRARY}")
  endif()

  message(STATUS "Verbose:                  ${CMAKE_VERBOSE_MAKEFILE}")

  if(DEFINED buildPedantic)
    message(STATUS "Pedantic:                 ${${buildPedantic}}")
  endif()

  if(DEFINED enableTests)
    message(STATUS "Testing:                  ${${enableTests}}")
  endif()
endfunction()
