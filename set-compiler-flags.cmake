# Copyright (c) 2019 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

macro(set_compiler_flags cxxStandard pedanticMode)

  set(CMAKE_CXX_STANDARD ${cxxStandard})
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
  set(CMAKE_CXX_EXTENSIONS OFF)

  if(MSVC)
    set(${PROJECT_NAME}_WARNING_FLAGS "/bigobj")
  else()
    set(${PROJECT_NAME}_WARNING_FLAGS "-W -Wall -Wextra -pedantic")
  endif()

  if(${CMAKE_CXX_COMPILER_ID} MATCHES GNU)
    set(
      ${PROJECT_NAME}_WARNING_FLAGS
      "${${PROJECT_NAME}_WARNING_FLAGS} -Wcast-align -Wctor-dtor-privacy -Wdouble-promotion -Wduplicated-branches -Wduplicated-cond -Weffc++ -Wformat=2 -Winit-self -Wlogical-op -Wmissing-declarations -Wmissing-include-dirs -Wnoexcept -Wnull-dereference -Wold-style-cast -Woverloaded-virtual -Wrestrict -Wshadow -Wstrict-null-sentinel -Wswitch-default -Wswitch-enum -Wundef -Wunused-macros"
    )
  elseif(${CMAKE_CXX_COMPILER_ID} MATCHES Clang)
    set(
      ${PROJECT_NAME}_WARNING_FLAGS
      "${${PROJECT_NAME}_WARNING_FLAGS} -Weverything -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-covered-switch-default -Wno-exit-time-destructors -Wno-global-constructors -Wno-missing-prototypes -Wno-missing-variable-declarations -Wno-padded -Wno-undefined-func-template -Wno-unknown-warning-option -Wno-weak-template-vtables -Wno-weak-vtables"
    )
  elseif(MSVC)
    set(
      ${PROJECT_NAME}_WARNING_FLAGS
      "${${PROJECT_NAME}_WARNING_FLAGS} /wd4068 /wd4250"
    )
  endif()

  if(NOT MSVC)
    set(
      ${PROJECT_NAME}_WARNING_FLAGS
      "${${PROJECT_NAME}_WARNING_FLAGS} -Wno-pragmas -Wno-unknown-pragmas"
    )
  endif()

  if(${pedanticMode})
    if(MSVC)
      set(${PROJECT_NAME}_PEDANTIC_FLAG "") # TODO
    else()
      set(${PROJECT_NAME}_PEDANTIC_FLAG "-Werror -pedantic-errors")
    endif()
  else()
    set(${PROJECT_NAME}_PEDANTIC_FLAG "")
  endif()

  set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} ${${PROJECT_NAME}_PEDANTIC_FLAG} ${${PROJECT_NAME}_WARNING_FLAGS}"
  )
endmacro()
