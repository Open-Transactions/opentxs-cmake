# Copyright (c) 2019 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

set(THREADS_PREFER_PTHREAD_FLAG ON)

macro(find_system_libraries)
  find_library(LIB_RT rt)
  find_library(LIB_ANDROID_LOG log)
  find_package(Threads REQUIRED)
endmacro()
