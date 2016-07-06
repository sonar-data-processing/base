cmake_minimum_required (VERSION 2.6)
project (base)

set ( WORKSPACE_DIR       ${PROJECT_SOURCE_DIR} CACHE STRING "Workspace Root Directory" )
set ( WORKSPACE_DATA_PATH ${WORKSPACE_DIR}/data CACHE STRING "Workspace Data Dath" )
set ( CMAKE_MODULE_PATH   ${CMAKE_MODULE_PATH} "${WORKSPACE_DIR}/base/cmake" CACHE STRING "CMake Module Path"  )

file ( GLOB SOURCES ${PROJECT_SOURCE_DIR}/src/*.cpp )
file ( GLOB HEADERS ${PROJECT_SOURCE_DIR}/src/*.hpp )

set ( 
    ${PROJECT_NAME}_INCLUDE_DIR 
    ${PROJECT_SOURCE_DIR}/include 
    ${PROJECT_BINARY_DIR}/include 
    CACHE INTERNAL "Base Library Include Directory" FORCE
)

include_directories ( ${base_INCLUDE_DIR} )

configure_file (
    ${PROJECT_SOURCE_DIR}/include/base/test_config.h.in
    ${PROJECT_BINARY_DIR}/include/base/test_config.h
    @ONLY
)
