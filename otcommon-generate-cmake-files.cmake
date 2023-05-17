# Copyright (c) 2020-2022 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

function(
  otcommon_generate_cmake_files
  template_file
  modules_dir
  install_location
)
  include(CMakePackageConfigHelpers)

  configure_package_config_file(
    "${template_file}"
    "${${PROJECT_NAME}_BINARY_DIR}/${modules_dir}/${PROJECT_NAME}Config.cmake"
    INSTALL_DESTINATION ${install_location}
    PATH_VARS modules_dir
    NO_SET_AND_CHECK_MACRO NO_CHECK_REQUIRED_COMPONENTS_MACRO
  )
  write_basic_package_version_file(
    "${${PROJECT_NAME}_BINARY_DIR}/${modules_dir}/${PROJECT_NAME}ConfigVersion.cmake"
    VERSION ${${PROJECT_NAME}_VERSION_STRING}
    COMPATIBILITY AnyNewerVersion
  )

  install(
    FILES
      "${${PROJECT_NAME}_BINARY_DIR}/${modules_dir}/${PROJECT_NAME}Config.cmake"
      "${${PROJECT_NAME}_BINARY_DIR}/${modules_dir}/${PROJECT_NAME}ConfigVersion.cmake"
    DESTINATION ${install_location}
    COMPONENT ${PROJECT_NAME}_cmake_modules
  )
  install(
    EXPORT ${PROJECT_NAME}
    DESTINATION ${install_location}
    NAMESPACE "${PROJECT_NAME}::"
  )
endfunction()
