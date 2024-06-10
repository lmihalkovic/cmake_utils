# A toolchain to cross-compile Windows 64 binaries on Cygwin
set(CMAKE_TOOLCHAIN_PREFIX x86_64-w64-mingw32)      ## 64bits
include("${CMAKE_CURRENT_LIST_DIR}/cygwin-Win.cmake")
