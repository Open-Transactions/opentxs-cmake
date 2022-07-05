# Copyright (c) 2020-2022 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

macro(
  set_compiler_flags
  cxxStandard
  pedanticMode
)

  set(CMAKE_CXX_STANDARD ${cxxStandard})
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
  set(CMAKE_CXX_EXTENSIONS OFF)

  if(MSVC)
    if("${CMAKE_MSVC_RUNTIME_LIBRARY}"
       STREQUAL
       ""
    )
      if("${VCPKG_TARGET_TRIPLET}"
         STREQUAL
         "x64-windows"
      )
        if("${CMAKE_BUILD_TYPE}"
           STREQUAL
           "Debug"
        )
          set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebugDLL")
        else()
          set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDLL")
        endif()
      elseif(
        "${VCPKG_TARGET_TRIPLET}"
        STREQUAL
        "x64-windows-static"
      )
        if("${CMAKE_BUILD_TYPE}"
           STREQUAL
           "Debug"
        )
          set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebug")
        else()
          set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded")
        endif()
      elseif(
        "${VCPKG_TARGET_TRIPLET}"
        STREQUAL
        "x64-windows-static-md"
      )
        if("${CMAKE_BUILD_TYPE}"
           STREQUAL
           "Debug"
        )
          set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebugDLL")
        else()
          set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDLL")
        endif()
      endif()
    endif()

    if("${CMAKE_MSVC_RUNTIME_LIBRARY}"
       STREQUAL
       "MultiThreaded"
    )
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MT")
      set(CMAKE_SHARED_LINKER_FLAGS
          "${CMAKE_SHARED_LINKER_FLAGS} /NODEFAULTLIB:msvcrt.lib /NODEFAULTLIB:libcmtd.lib /NODEFAULTLIB:msvcrtd.lib"
      )
      set(CMAKE_STATIC_LINKER_FLAGS
          "${CMAKE_STATIC_LINKER_FLAGS} /NODEFAULTLIB:msvcrt.lib /NODEFAULTLIB:libcmtd.lib /NODEFAULTLIB:msvcrtd.lib"
      )
      set(CMAKE_EXE_LINKER_FLAGS
          "${CMAKE_EXE_LINKER_FLAGS} /NODEFAULTLIB:msvcrt.lib /NODEFAULTLIB:libcmtd.lib /NODEFAULTLIB:msvcrtd.lib"
      )
    elseif(
      "${CMAKE_MSVC_RUNTIME_LIBRARY}"
      STREQUAL
      "MultiThreadedDLL"
    )
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MD")
      set(CMAKE_SHARED_LINKER_FLAGS
          "${CMAKE_SHARED_LINKER_FLAGS} /NODEFAULTLIB:libcmt.lib /NODEFAULTLIB:libcmtd.lib /NODEFAULTLIB:msvcrtd.lib"
      )
      set(CMAKE_STATIC_LINKER_FLAGS
          "${CMAKE_STATIC_LINKER_FLAGS} /NODEFAULTLIB:libcmt.lib /NODEFAULTLIB:libcmtd.lib /NODEFAULTLIB:msvcrtd.lib"
      )
      set(CMAKE_EXE_LINKER_FLAGS
          "${CMAKE_EXE_LINKER_FLAGS} /NODEFAULTLIB:libcmt.lib /NODEFAULTLIB:libcmtd.lib /NODEFAULTLIB:msvcrtd.lib"
      )
    elseif(
      "${CMAKE_MSVC_RUNTIME_LIBRARY}"
      STREQUAL
      "MultiThreadedDebug"
    )
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MTd")
      set(CMAKE_SHARED_LINKER_FLAGS
          "${CMAKE_SHARED_LINKER_FLAGS} /NODEFAULTLIB:libcmt.lib /NODEFAULTLIB:msvcrt.lib /NODEFAULTLIB:msvcrtd.lib"
      )
      set(CMAKE_STATIC_LINKER_FLAGS
          "${CMAKE_STATIC_LINKER_FLAGS} /NODEFAULTLIB:libcmt.lib /NODEFAULTLIB:msvcrt.lib /NODEFAULTLIB:msvcrtd.lib"
      )
      set(CMAKE_EXE_LINKER_FLAGS
          "${CMAKE_EXE_LINKER_FLAGS} /NODEFAULTLIB:libcmt.lib /NODEFAULTLIB:msvcrt.lib /NODEFAULTLIB:msvcrtd.lib"
      )
    elseif(
      "${CMAKE_MSVC_RUNTIME_LIBRARY}"
      STREQUAL
      "MultiThreadedDebugDLL"
    )
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MDd")
      set(CMAKE_SHARED_LINKER_FLAGS
          "${CMAKE_SHARED_LINKER_FLAGS} /NODEFAULTLIB:libcmt.lib /NODEFAULTLIB:msvcrt.lib /NODEFAULTLIB:libcmtd.lib"
      )
      set(CMAKE_STATIC_LINKER_FLAGS
          "${CMAKE_STATIC_LINKER_FLAGS} /NODEFAULTLIB:libcmt.lib /NODEFAULTLIB:msvcrt.lib /NODEFAULTLIB:libcmtd.lib"
      )
      set(CMAKE_EXE_LINKER_FLAGS
          "${CMAKE_EXE_LINKER_FLAGS} /NODEFAULTLIB:libcmt.lib /NODEFAULTLIB:msvcrt.lib /NODEFAULTLIB:libcmtd.lib"
      )
    else()
      message(FATAL_ERROR "Setting CMAKE_MSVC_RUNTIME_LIBRARY is required")
    endif()
  endif()

  if(MSVC)
    set(${PROJECT_NAME}_WARNING_FLAGS "/bigobj")
  else()
    set(${PROJECT_NAME}_WARNING_FLAGS "-W -Wall -Wextra -pedantic")
  endif()

  if(${CMAKE_CXX_COMPILER_ID}
     MATCHES
     GNU
  )
    set(${PROJECT_NAME}_WARNING_FLAGS
        "${${PROJECT_NAME}_WARNING_FLAGS} -Wcast-align -Wctor-dtor-privacy -Wdouble-promotion -Wduplicated-branches -Wduplicated-cond -Weffc++ -Wformat=2 -Winit-self -Wlogical-op -Wmissing-declarations -Wmissing-include-dirs -Wnoexcept -Wnull-dereference -Wold-style-cast -Woverloaded-virtual -Wrestrict -Wshadow -Wstrict-null-sentinel -Wswitch-default -Wswitch-enum -Wundef -Wunused-macros"
    )
  elseif(
    ${CMAKE_CXX_COMPILER_ID}
    MATCHES
    Clang
  )
    set(${PROJECT_NAME}_WARNING_FLAGS
        "${${PROJECT_NAME}_WARNING_FLAGS} -Weverything -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-covered-switch-default -Wno-exit-time-destructors -Wno-global-constructors -Wno-missing-prototypes -Wno-missing-variable-declarations -Wno-padded -Wno-undefined-func-template -Wno-unknown-warning-option -Wno-weak-template-vtables -Wno-weak-vtables"
    )
  elseif(MSVC)
    set(${PROJECT_NAME}_WARNING_FLAGS
        "${${PROJECT_NAME}_WARNING_FLAGS} /W3 /wd4068 /wd4250"
    )
  endif()

  if(NOT MSVC)
    set(${PROJECT_NAME}_WARNING_FLAGS
        "${${PROJECT_NAME}_WARNING_FLAGS} -Wno-pragmas -Wno-unknown-pragmas"
    )
  endif()

  if(${pedanticMode})
    if(MSVC)
      set(${PROJECT_NAME}_PEDANTIC_FLAG "/WX")
      set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /WX")
      set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /WX")
      set(CMAKE_STATIC_LINKER_FLAGS "${CMAKE_STATIC_LINKER_FLAGS} /WX")
    else()
      set(${PROJECT_NAME}_PEDANTIC_FLAG "-Werror -pedantic-errors")
    endif()
  else()
    set(${PROJECT_NAME}_PEDANTIC_FLAG "")
  endif()

  set(CMAKE_CXX_FLAGS
      "${CMAKE_CXX_FLAGS} ${${PROJECT_NAME}_PEDANTIC_FLAG} ${${PROJECT_NAME}_WARNING_FLAGS}"
  )
endmacro()
