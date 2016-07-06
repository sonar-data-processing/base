macro (boost_test_init)
    enable_testing()
    add_definitions ( -DBOOST_TEST_DYN_LINK )
endmacro()

function ( add_boost_test TARGET_NAME  )
    set (VALID_ARGS "SOURCES;LIBRARIES")

    set (CURRENT_ARGUMENT "SOURCES")
    foreach(ELEMENT ${ARGN})
        list(FIND VALID_ARGS ${ELEMENT} IS_VALID_ARG)
        if ( IS_VALID_ARG GREATER "-1" )
            set (CURRENT_ARGUMENT ${ELEMENT})
        else()
            list ( APPEND ${CURRENT_ARGUMENT} ${ELEMENT} )
        endif()
    endforeach()

    add_executable ( ${TARGET_NAME} ${SOURCES} )

    target_link_libraries ( ${TARGET_NAME} ${LIBRARIES} )

    add_test (
        NAME "test-${TARGET_NAME}"
        COMMAND ${TARGET_NAME} --log_level=message
    )
    
endfunction()
