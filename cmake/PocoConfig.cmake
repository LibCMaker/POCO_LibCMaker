# ****************************************************************************
#  Project:  LibCMaker
#  Purpose:  A CMake build scripts for build libraries with CMake
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017-2026 NikitaFeodonit
#
#    This file is part of the LibCMaker project.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published
#    by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.
# ****************************************************************************


#-----------------------------------------------------------------------
# Library version
#

set(POCO_lib_VERSION "1.15.3" CACHE STRING "POCO_lib_VERSION")
set(POCO_sha256
  "562a1ba1a6db4665f81091c35e997b73f87e1b45e2ab2854cd720d2349518abc"
  CACHE STRING "POCO_sha256"
)


#-----------------------------------------------------------------------
# POCO options
#

option(BUILD_SHARED_LIBS "Build shared libraries" ON)

option(POCO_MINIMAL_BUILD "Build only bare minimum Poco libraries identifoed with ENABLE options." OFF)

if(MSVC)
  option(POCO_MT "Set to OFF|ON (default is OFF) to control static build of POCO as /MT instead of /MD" OFF)
endif()

# POCO_UNBUNDLED / POCO_SQLITE_UNBUNDLED are declared here because
# dependencies/zlib reads them. ENABLE_TRACE / ENABLE_FASTLOGGER and
# DefinePlatformSpecific are pulled up so their directory-scope compile
# definitions reach a bundled zlib object library.

option(POCO_UNBUNDLED
  "Set to OFF|ON (default is OFF) to control linking dependencies as external" OFF)

option(POCO_SQLITE_UNBUNDLED
  "Set to OFF|ON (default is OFF) to control linking sqlite dependency as external" OFF)

option(ENABLE_TRACE "Enable stack tracing" OFF)
option(ENABLE_FASTLOGGER "Enable FastLogger (Quill-based high-performance logger)" ON)

option(ENABLE_NETSSL "Enable NetSSL" OFF)
option(ENABLE_CRYPTO "Enable Crypto" OFF)
option(ENABLE_JWT "Enable JWT" OFF)
option(ENABLE_APACHECONNECTOR "Enable ApacheConnector" OFF)
option(ENABLE_DATA_MYSQL "Enable Data MySQL or MariaDB" OFF)
option(ENABLE_DATA_POSTGRESQL "Enable Data PosgreSQL" OFF)
option(ENABLE_DATA_ODBC "Enable Data ODBC" OFF)
option(ENABLE_DATA_SQL_SERVER_BIG_STRINGS "Enable MS SQL Server big strings" OFF)

set(_enable_default ON)

# Allow enabling and disabling optional components

option(ENABLE_ENCODINGS "Enable Encodings" ${_enable_default})
option(ENABLE_XML "Enable XML" ${_enable_default})
option(ENABLE_JSON "Enable JSON" ${_enable_default})
option(ENABLE_DATA "Enable Data" ${_enable_default})
option(ENABLE_DATA_SQLITE "Enable Data SQlite" ${_enable_default})
option(ENABLE_MONGODB "Enable MongoDB" OFF)
option(ENABLE_REDIS "Enable Redis" OFF)
option(ENABLE_PROMETHEUS "Enable Prometheus" OFF)
option(ENABLE_UTIL "Enable Util" ${_enable_default})
option(ENABLE_NET "Enable Net" ${_enable_default})
option(ENABLE_ZIP "Enable Zip" ${_enable_default})
option(ENABLE_PAGECOMPILER "Enable PageCompiler" ${_enable_default})
option(ENABLE_PAGECOMPILER_FILE2PAGE "Enable File2Page" ${_enable_default})
option(ENABLE_ACTIVERECORD "Enable ActiveRecord" OFF)
option(ENABLE_ACTIVERECORD_COMPILER "Enable ActiveRecord Compiler" OFF)

set(ENABLE_NETSSL_WIN OFF CACHE BOOL "Enable NetSSL Windows (Windows only)" FORCE)

option(ENABLE_ENCODINGS_COMPILER "Enable Encodings Compiler" OFF)
option(ENABLE_DNSSD "Enable DNSSD" OFF)
option(ENABLE_DNSSD_DEFAULT "Enable DNSSD Default" OFF)
option(ENABLE_DNSSD_AVAHI "Enable DNSSD Avahi" OFF)
option(ENABLE_DNSSD_BONJOUR "Enable DNSSD Bonjour" OFF)
option(ENABLE_SEVENZIP "Enable SevenZip" ON)
option(ENABLE_CPPPARSER "Enable C++ parser" OFF)
option(ENABLE_POCODOC "Enable Poco Documentation Generator" OFF)
option(ENABLE_PDF "Enable PDF" ON)

option(ENABLE_MODULES "Build Poco.* C++ modules" OFF)

option(ENABLE_BENCHMARK
  "Set to OFF|ON (default is OFF) to enable Benchmark application (requires Google Benchmark library)" OFF)

option(ENABLE_CPPUNIT
  "Set to OFF|ON (default is OFF) to enable CppUnit library" OFF)

option(ENABLE_INSTALL_CPPUNIT
  "Set to OFF|ON (default is OFF) to install CppUnit headers and libraries" OFF)

option(ENABLE_TESTS
  "Set to OFF|ON (default is OFF) to control build of POCO tests" OFF)

option(ENABLE_TEST_DEPRECATED
  "Set to OFF|ON (default is OFF) to enable build of tests for deprecated functionality" OFF)

option(POCO_DATA_NO_SQL_PARSER "Disable SQL parser" OFF)

option(ENABLE_COMPILER_WARNINGS
  "Set to OFF|ON (default is OFF) to enable additional compiler warnings. Intended primarily for maintainers." OFF)

option(ENABLE_SAMPLES
  "Set to OFF|ON (default is OFF) to control build of POCO samples" OFF)

option(ENABLE_FUZZING
  "Set to OFF|ON (default is OFF) to control build of fuzzing targets for oss-fuzz (Clang compiler is required)" OFF)

option(POCO_SOO
  "Set to OFF|ON (default is ON) to control small object optimization in Poco::Foundation" ON)

# Disable fork exec
option(POCO_NO_FORK_EXEC "Set to OFF|ON (default is OFF) to disable use of fork() and exec*() which are not allowed on some Apple platforms (iOS, watchOS, iPadOS, tvOS)." OFF)

option(POCO_ENABLE_STD_MUTEX "Set to OFF|NO using mutex from standard library (default OFF)" OFF)


#-----------------------------------------------------------------------
# Unpack, configure and build the required libraries
#

include(FetchContent)

FetchContent_Declare(
  Poco
  URL ${CMAKE_CURRENT_LIST_DIR}/source/poco-${POCO_lib_VERSION}-all.tar.bz2
  URL_HASH SHA256=${POCO_sha256}
  OVERRIDE_FIND_PACKAGE
)

FetchContent_MakeAvailable(Poco)
