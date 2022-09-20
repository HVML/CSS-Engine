include(GlobalCommon)

CSSENG_EXECUTABLE_DECLARE(csspropgen)

list(APPEND csspropgen_PRIVATE_INCLUDE_DIRECTORIES
)

list(APPEND csspropgen_SYSTEM_INCLUDE_DIRECTORIES
)

list(APPEND csspropgen_SOURCES
    css_property_parser_gen.c
)

set(csspropgen_LIBRARIES
)

CSSENG_EXECUTABLE(csspropgen)
CSSENG_COMPUTE_SOURCES(csspropgen)

