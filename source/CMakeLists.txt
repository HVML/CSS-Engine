# -----------------------------------------------------------------------------
# Add components directories
# -----------------------------------------------------------------------------
add_subdirectory(wtf)

add_subdirectory(cssengine)

if (ENABLE_API_TESTS)
    add_subdirectory(test)
endif ()

add_subdirectory(samples)

FOOBAR_INCLUDE_CONFIG_FILES_IF_EXISTS()
