---
title: 'Cmake Basic'
date: 2024-07-01T02:04:12+02:00
draft: false
tags: ["C", "Cmake"]
weight: 10
typora-copy-images-to: ${filename}.assets
summary: CMakeLists.txt
# cover:
#   image: /poi.jpg
#   caption: "poi"
---

```cmake
cmake_minimum_required(VERSION 3.15)

# support gdb
SET(CMAKE_BUILD_TYPE "Debug")
SET(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g2 -ggdb")
SET(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")


find_package(mynteye REQUIRED)
message(STATUS "Found mynteye: ${mynteye_VERSION}")

find_package(OpenCV REQUIRED)
message(STATUS "Found OpenCV: ${OpenCV_VERSION}")

include_directories(
  ${OpenCV_INCLUDE_DIRS}
)

set(SRC_PATH ${PROJECT_SOURCE_DIR}/src)
file(GLOB SRC_FILES
  "${SRC_PATH}/*.cpp"
)

foreach(FILE_PATH ${SRC_FILES})
  message("file_path: "${FILE_PATH})
  string(REGEX REPLACE ".+/(.+)\\..*" "\\1" FILE_NAME ${FILE_PATH})
  message("file_name: "${FILE_NAME})
  add_executable(${PROJECT_NAME}_${FILE_NAME} ${FILE_PATH})
  target_link_libraries(${PROJECT_NAME}_${FILE_NAME} ${OpenCV_LIBS} ${OpenCV_LIB_SEARCH_PATH} mynteye)
endforeach(_cpp ${SRC_FILES})
```