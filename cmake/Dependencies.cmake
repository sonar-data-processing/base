macro (add_project_dependency PROJECT_NAME SOURCE_PATH BINARY_PATH)
    if (NOT TARGET ${PROJECT_NAME})
        add_subdirectory (${SOURCE_PATH}/${PROJECT_NAME} ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME} )
        setup_headers( ${PROJECT_NAME} ${SOURCE_PATH}/${PROJECT_NAME} )
        setup_headers( ${PROJECT_NAME} ${SOURCE_PATH}/${PROJECT_NAME}/src )
        setup_headers( ${PROJECT_NAME} ${SOURCE_PATH}/${PROJECT_NAME}/include )
    endif()
endmacro()

macro (setup_headers PROJECT_NAME SOURCE_PATH)
    file ( GLOB HEADERS "${SOURCE_PATH}/*.hpp")
    foreach(FILENAME ${HEADERS})
        get_filename_component (HEADER ${FILENAME} NAME)
        configure_file (
            ${FILENAME}
            ${CMAKE_BINARY_DIR}/include/${PROJECT_NAME}/${HEADER}
            @ONLY)
    endforeach()
endmacro()

macro (configure_file_list INPUT_LIST OUTPUT_PATH)
    foreach(FILEPATH ${INPUT_LIST})
        get_filename_component (FILENAME ${FILEPATH} NAME)
        configure_file (
            ${FILEPATH}
            ${OUTPUT_PATH}/${FILENAME}
            @ONLY)
    endforeach()
endmacro()
