# GetCPM.cmake
#
# downloader for CPM

set(CPM_TAG v0.39.0)
set(CPM_TAG_HASH 66639bcac9dd2907b2918de466783554c1334446b9874e90d38e3778d404c2ef)

file(
  DOWNLOAD
  https://github.com/cpm-cmake/CPM.cmake/releases/download/${CPM_TAG}/CPM.cmake
  ${CMAKE_CURRENT_BINARY_DIR}/cmake/CPM.cmake
  EXPECTED_HASH SHA256=${CPM_TAG_HASH}
)
include(${CMAKE_CURRENT_BINARY_DIR}/cmake/CPM.cmake)

message(STATUS "CPM Cache: ${CPM_SOURCE_CACHE}")
