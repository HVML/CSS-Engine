include(GlobalCommon)
include(target/CSSEng)

CSSENG_EXECUTABLE_DECLARE(examples)

list(APPEND examples_INCLUDE_DIRECTORIES
    ${FORWARDING_HEADERS_DIR}
)

set(examples_SOURCES
    example1.c
)

set(examples_LIBRARIES
    CSSEng::CSSEng
)

CSSENG_EXECUTABLE(examples)

CSSENG_COMPUTE_SOURCES(examples)
CSSENG_FRAMEWORK(examples)
