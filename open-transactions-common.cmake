# Copyright (c) 2020 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# cmake_minimum_required
#  3.0:  FindGit
#  3.0:  FindGnuTLS
#  3.1:  FindThreads
#  3.1:  FindZLIB
#  3.4:  FindOpenSSL
#  3.5:  FindBoost
#  3.5:  FindGTest
#  3.8:  CXX_STANDARD 17 and cxx_std_17
#  3.9:  FindProtobuf
#  3.14: FindSQLite3

include(GNUInstallDirs)
include(define-job-pools)
include(find-system-libraries)
include(generate-cmake-files)
include(generate-pkgconfig)
include(generate-uninstall-target)
include(hide-symbols)
include(print-build-details)
include(set-build-type)
include(set-common-defines)
include(set-compiler-flags)
include(set-out-of-source-build)
include(set-version-from-git)
include(update-git-submodules)
