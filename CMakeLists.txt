cmake_minimum_required (VERSION 2.8)
project (base)

list(APPEND CMAKE_MODULE_PATH ${base_SOURCE_DIR}/cmake)
list(APPEND CMAKE_MODULE_PATH $ENV{SONAR_TOOLKIT_PREFIX}/third_party/cmake)

set ( SONAR_TOOLKIT_DATA $ENV{SONAR_TOOLKIT_PREFIX}/data )

include ( FindPkgConfig )
include ( Gnuplot )
find_package ( Boost COMPONENTS system filesystem program_options iostreams REQUIRED )

file ( GLOB SOURCES ${PROJECT_SOURCE_DIR}/src/*.cpp )
file ( GLOB HEADERS src/*.hpp )

include_directories (
    ${gnuplot_INCLUDE_DIR}
    ${PROJECT_SOURCE_DIR}/src
    ${CMAKE_INSTALL_PREFIX}/include/sonar_toolkit
)

configure_file (
    ${PROJECT_SOURCE_DIR}/include/test_config.h.in
    ${CMAKE_INSTALL_PREFIX}/include/sonar_toolkit/base/test_config.h
    @ONLY
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

install(FILES
    cmake/BoostTest.cmake
    cmake/Dependencies.cmake
    DESTINATION share/sonar_toolkit/${PROJECT_NAME}/cmake
)

install(
    FILES ${HEADERS}
    DESTINATION include/sonar_toolkit/${PROJECT_NAME}
)

install(
    TARGETS base
    DESTINATION lib/sonar_toolkit
)

install(TARGETS
    basic_plot
    DESTINATION bin
)
