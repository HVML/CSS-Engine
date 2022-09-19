if (NOT TARGET CSSEng::CSSEng)
    if (NOT INTERNAL_BUILD)
        message(FATAL_ERROR "CSSEng::CSSEng target not found")
    endif ()

    # This should be moved to an if block if the Apple Mac/iOS build moves completely to CMake
    # Just assuming Windows for the moment
    add_library(CSSEng::CSSEng STATIC IMPORTED)
    set_target_properties(CSSEng::CSSEng PROPERTIES
        IMPORTED_LOCATION ${WEBKIT_LIBRARIES_LINK_DIR}/CSSEng${DEBUG_SUFFIX}.lib
    )
    set(CSSEng_PRIVATE_FRAMEWORK_HEADERS_DIR "${CMAKE_BINARY_DIR}/../include/private")
    target_include_directories(CSSEng::CSSEng INTERFACE
        ${CSSEng_PRIVATE_FRAMEWORK_HEADERS_DIR}
    )
endif ()
