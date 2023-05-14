# Copyright (c) 2020-2022 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

macro(
  otcommon_set_project_language_standard
  cStandard
  cxxStandard
  pedanticMode
)
  set(${PROJECT_NAME}_CXX_STANDARD ${cxxStandard})
  set(${PROJECT_NAME}_C_STANDARD ${cStandard})
  set(${PROJECT_NAME}_PEDANTIC_COMPILER_FLAGS ${pedanticMode})

  if(MSVC)
    if(${PROJECT_NAME}_PEDANTIC_COMPILER_FLAGS)
      set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /WX")
      set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /WX")
      set(CMAKE_STATIC_LINKER_FLAGS "${CMAKE_STATIC_LINKER_FLAGS} /WX")
    endif()

    include(otcommon-detect-msvc-standard-library-from-vcpkg-triplet)
    otcommon_detect_msvc_standard_library_from_vcpkg_triplet()

    if("${CMAKE_MSVC_RUNTIME_LIBRARY}"
       STREQUAL
       ""
    )
      set(MSVC_RUNTIME_LIBRARY
          "MultiThreaded$<$<CONFIG:Debug>:Debug>${${PROJECT_NAME}_MSVC_RUNTIME_LIBRARY_SUFFIX}"
      )
      set(CMAKE_MSVC_RUNTIME_LIBRARY "${MSVC_RUNTIME_LIBRARY}")
    else()
      set(MSVC_RUNTIME_LIBRARY "${CMAKE_MSVC_RUNTIME_LIBRARY}")
    endif()

    if("${MSVC_RUNTIME_LIBRARY}"
       STREQUAL
       "MultiThreaded"
    )
      if(NOT DEFINED)
        set(OPENSSL_MSVC_STATIC_RT ON)
      endif()

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
      "${MSVC_RUNTIME_LIBRARY}"
      STREQUAL
      "MultiThreadedDLL"
    )
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
      "${MSVC_RUNTIME_LIBRARY}"
      STREQUAL
      "MultiThreadedDebug"
    )
      if(NOT DEFINED)
        set(OPENSSL_MSVC_STATIC_RT ON)
      endif()

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
      "${MSVC_RUNTIME_LIBRARY}"
      STREQUAL
      "MultiThreadedDebugDLL"
    )
      set(CMAKE_SHARED_LINKER_FLAGS
          "${CMAKE_SHARED_LINKER_FLAGS} /NODEFAULTLIB:libcmt.lib /NODEFAULTLIB:msvcrt.lib /NODEFAULTLIB:libcmtd.lib"
      )
      set(CMAKE_STATIC_LINKER_FLAGS
          "${CMAKE_STATIC_LINKER_FLAGS} /NODEFAULTLIB:libcmt.lib /NODEFAULTLIB:msvcrt.lib /NODEFAULTLIB:libcmtd.lib"
      )
      set(CMAKE_EXE_LINKER_FLAGS
          "${CMAKE_EXE_LINKER_FLAGS} /NODEFAULTLIB:libcmt.lib /NODEFAULTLIB:msvcrt.lib /NODEFAULTLIB:libcmtd.lib"
      )
    endif()

    set(${PROJECT_NAME}_MSVC_RUNTIME_LIBRARY "${MSVC_RUNTIME_LIBRARY}")
  endif()
endmacro()
