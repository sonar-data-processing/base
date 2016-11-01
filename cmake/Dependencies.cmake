macro (add_project_dependency PROJECT_NAME SOURCE_PATH BINARY_PATH)
    if (NOT TARGET ${PROJECT_NAME})
        add_subdirectory (${SOURCE_PATH}/${PROJECT_NAME} ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME} )
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

    file ( GLOB HEADERS "${SOURCE_PATH}/*.h")
    foreach(FILENAME ${HEADERS})
        get_filename_component (HEADER ${FILENAME} NAME)
        configure_file (
            ${FILENAME}
            ${CMAKE_BINARY_DIR}/include/${PROJECT_NAME}/${HEADER}
            @ONLY)
    endforeach()

    file ( GLOB CHILDREN RELATIVE ${SOURCE_PATH} ${SOURCE_PATH}/[^.]* )
    list ( REMOVE_ITEM CHILDREN "*.*" )

    foreach (CHILD ${CHILDREN})
        if ( IS_DIRECTORY ${SOURCE_PATH}/${CHILD} )
            setup_headers( ${PROJECT_NAME}/${CHILD} ${SOURCE_PATH}/${CHILD})
        endif()
    endforeach()

endmacro()

function (configure_file_list)

    set (VALID_ARGS "INPUT_FILES;OUTPUT_DIR")
    set (CURRENT_ARGUMENT "INPUT_FILES")

    foreach(ELEMENT ${ARGN})
        list(FIND VALID_ARGS ${ELEMENT} IS_VALID_ARG)
        if ( IS_VALID_ARG GREATER "-1" )
            set (CURRENT_ARGUMENT ${ELEMENT})
        else()
            list ( APPEND ${CURRENT_ARGUMENT} ${ELEMENT} )
        endif()
    endforeach()

    foreach(FILEPATH ${INPUT_FILES})
        get_filename_component (FILENAME ${FILEPATH} NAME)
        message( STATUS "${FILEPATH}" )
        configure_file (
            ${FILEPATH}
            ${OUTPUT_DIR}/${FILENAME}
            @ONLY)
    endforeach()
endfunction()
