# Copyright (c) 2020-2022 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

function(otcommon_generate_cmake_files template_file)
  include(CMakePackageConfigHelpers)
  set(MODULES_DIR "cmake")
  set(${PROJECT_NAME}_CMAKE_DEST
      "${CMAKE_INSTALL_LIBDIR}/${MODULES_DIR}/${PROJECT_NAME}"
  )

  configure_package_config_file(
    "${template_file}"
    "${${PROJECT_NAME}_BINARY_DIR}/${MODULES_DIR}/${PROJECT_NAME}Config.cmake"
    INSTALL_DESTINATION ${${PROJECT_NAME}_CMAKE_DEST}
    PATH_VARS MODULES_DIR
    NO_SET_AND_CHECK_MACRO NO_CHECK_REQUIRED_COMPONENTS_MACRO
  )

  write_basic_package_version_file(
    "${${PROJECT_NAME}_BINARY_DIR}/${MODULES_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    VERSION ${${PROJECT_NAME}_VERSION_STRING}
    COMPATIBILITY AnyNewerVersion
  )

  install(
    FILES
      "${${PROJECT_NAME}_BINARY_DIR}/${MODULES_DIR}/${PROJECT_NAME}Config.cmake"
      "${${PROJECT_NAME}_BINARY_DIR}/${MODULES_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    DESTINATION ${${PROJECT_NAME}_CMAKE_DEST}
    COMPONENT ${PROJECT_NAME}_cmake_modules
  )

  install(
    EXPORT ${PROJECT_NAME}
    DESTINATION ${${PROJECT_NAME}_CMAKE_DEST}
    NAMESPACE "${PROJECT_NAME}::"
  )
endfunction()
