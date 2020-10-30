# Copyright (c) 2020 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

function(generate_pkgconfig linkString)
  string(
    REGEX
    REPLACE
      "^${CMAKE_INSTALL_PREFIX}(.*)"
      "\\1"
      LIB_INSTALL_DIR
      "${CMAKE_INSTALL_LIBDIR}"
  )

  configure_file(
    "${${PROJECT_NAME}_SOURCE_DIR}/cmake/project.pc.in"
    "${${PROJECT_NAME}_BINARY_DIR}/${PROJECT_NAME}.pc.in" @ONLY
  )
  configure_file(
    "${${PROJECT_NAME}_BINARY_DIR}/${PROJECT_NAME}.pc.in"
    "${${PROJECT_NAME}_BINARY_DIR}/${PROJECT_NAME}.pc" @ONLY
  )

  install(
    FILES "${${PROJECT_NAME}_BINARY_DIR}/${PROJECT_NAME}.pc"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/pkgconfig"
    COMPONENT main
  )
endfunction()
