# Copyright (c) 2020-2022 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

macro(set_rpath)
  if(APPLE)
    set(basePoint @loader_path)
  else()
    set(basePoint $ORIGIN)
  endif()

  file(
    RELATIVE_PATH
    relDir
    ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}
    ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}
  )

  set(CMAKE_INSTALL_RPATH ${basePoint} ${basePoint}/${relDir})
endmacro()
