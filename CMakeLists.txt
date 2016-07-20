cmake_minimum_required (VERSION 2.8)
project (base)

set ( WORKSPACE_DIR       ${PROJECT_SOURCE_DIR} CACHE PATH "Workspace Root Directory" )
set ( WORKSPACE_DATA_PATH ${WORKSPACE_DIR}/data CACHE PATH "Workspace Data Dath" )
set ( CMAKE_MODULE_PATH   ${CMAKE_MODULE_PATH} "${WORKSPACE_DIR}/base/cmake" CACHE PATH "CMake Module Path"  )

include ( "${WORKSPACE_DIR}/third_party/cmake/Gnuplot.cmake"  )
include ( Dependencies )
include ( FindPkgConfig  )
include ( BoostTest )

find_package ( Boost COMPONENTS system filesystem program_options iostreams REQUIRED )

file ( GLOB SOURCES ${PROJECT_SOURCE_DIR}/src/*.cpp )

setup_headers ( ${PROJECT_NAME} "${CMAKE_CURRENT_SOURCE_DIR}/src" )

set ( 
    ${PROJECT_NAME}_INCLUDE_DIR 
    ${PROJECT_SOURCE_DIR}/src
    ${CMAKE_BINARY_DIR}/include
    CACHE PATH "Base Library Include Directory"
    FORCE
)

include_directories ( ${base_INCLUDE_DIR} )

configure_file (
    ${PROJECT_SOURCE_DIR}/include/test_config.h.in
    ${CMAKE_BINARY_DIR}/include/base/test_config.h
    @ONLY
)

include_directories (
    ${gnuplot_INCLUDE_DIR}
)

add_library (
    base
    ${SOURCES}
)

add_executable (
    basic_plot
    examples/basic_plot.cpp
)

target_link_libraries (
    basic_plot
    base
    ${Boost_LIBRARIES}
)
