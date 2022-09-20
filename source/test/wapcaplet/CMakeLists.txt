include(GlobalCommon)

# testmain
CSSENG_EXECUTABLE_DECLARE(testmain)

list(APPEND testmain_PRIVATE_INCLUDE_DIRECTORIES
    "${CSSENG_DIR}"
)

list(APPEND testmain_SYSTEM_INCLUDE_DIRECTORIES
    "${FORWARDING_HEADERS_DIR}/csseng"
    "${LIBCHECK_INCLUDE_DIRS}"
)

list(APPEND testmain_SOURCES
    testmain.c
    basictests.c
)

set(testmain_LIBRARIES
    CSSEng::CSSEng
    ${LIBCHECK_LIBRARIES}
)

CSSENG_EXECUTABLE(testmain)
CSSENG_COMPUTE_SOURCES(testmain)

