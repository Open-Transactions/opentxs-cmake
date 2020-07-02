# Copyright (c) 2020 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

function(generate_cmake_files)
  include(CMakePackageConfigHelpers)
  set(CMAKE_CONFIG_DEST "${CMAKE_INSTALL_LIBDIR}/${PROJECT_NAME}")
  set(${PROJECT_NAME}_INCLUDE_DIRS "${CMAKE_INSTALL_PREFIX}/include")

  if(BUILD_SHARED_LIBS)
    set(
      ${PROJECT_NAME}_LIBRARIES
      "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/${CMAKE_SHARED_LIBRARY_PREFIX}${PROJECT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX}"
    )
  else()
    set(
      ${PROJECT_NAME}_LIBRARIES
      "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/${CMAKE_STATIC_LIBRARY_PREFIX}${PROJECT_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX}"
    )
  endif()

  set(PACKAGE_INIT_STRING "@PACKAGE_INIT@")
  set(INCLUDE_DIRS_STRING "@PACKAGE_${PROJECT_NAME}_INCLUDE_DIRS@")
  set(LIBRARIES_STRING "@PACKAGE_${PROJECT_NAME}_LIBRARIES@")

  configure_file("${${PROJECT_NAME}_SOURCE_DIR}/cmake/projectConfig.cmake.in"
                 "${${PROJECT_NAME}_BINARY_DIR}/${PROJECT_NAME}Config.cmake.in"
                 @ONLY)

  configure_package_config_file(
    "${${PROJECT_NAME}_BINARY_DIR}/${PROJECT_NAME}Config.cmake.in"
    "${${PROJECT_NAME}_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    INSTALL_DESTINATION
    ${CMAKE_CONFIG_DEST}
    PATH_VARS
    ${PROJECT_NAME}_INCLUDE_DIRS
    ${PROJECT_NAME}_LIBRARIES
  )

  write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    VERSION ${${PROJECT_NAME}_VERSION_STRING}
    COMPATIBILITY AnyNewerVersion
  )

  install(
    FILES
      "${${PROJECT_NAME}_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
      "${${PROJECT_NAME}_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    DESTINATION ${CMAKE_CONFIG_DEST}
    COMPONENT dev
  )

  install(EXPORT ${PROJECT_NAME}-targets DESTINATION ${CMAKE_CONFIG_DEST})
endfunction()
