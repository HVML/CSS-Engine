# -----------------------------------------------------------------------------
# Add components directories
# -----------------------------------------------------------------------------
add_subdirectory(wtf)

add_subdirectory(csseng)

if (ENABLE_API_TESTS)
    add_subdirectory(test)
endif ()

add_subdirectory(examples)

CSSENG_INCLUDE_CONFIG_FILES_IF_EXISTS()
