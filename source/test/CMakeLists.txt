include(GlobalCommon)

# csdetect
CSSENG_EXECUTABLE_DECLARE(csdetect)

list(APPEND csdetect_PRIVATE_INCLUDE_DIRECTORIES
    "${CSSENG_DIR}"
)

list(APPEND csdetect_SYSTEM_INCLUDE_DIRECTORIES
    "${FORWARDING_HEADERS_DIR}/csseng"
)

list(APPEND csdetect_SOURCES
    csdetect.c
)

set(csdetect_LIBRARIES
    CSSEng::CSSEng
)

CSSENG_EXECUTABLE(csdetect)
CSSENG_COMPUTE_SOURCES(csdetect)

# lexauto
CSSENG_EXECUTABLE_DECLARE(lexauto)

list(APPEND lexauto_PRIVATE_INCLUDE_DIRECTORIES
    "${CSSENG_DIR}"
)

list(APPEND lexauto_SYSTEM_INCLUDE_DIRECTORIES
    "${FORWARDING_HEADERS_DIR}/csseng"
)

list(APPEND lexauto_SOURCES
    lexauto.c
)

set(lexauto_LIBRARIES
    CSSEng::CSSEng
)

CSSENG_EXECUTABLE(lexauto)
CSSENG_COMPUTE_SOURCES(lexauto)

# number
CSSENG_EXECUTABLE_DECLARE(number)

list(APPEND number_PRIVATE_INCLUDE_DIRECTORIES
    "${CSSENG_DIR}"
)

list(APPEND number_SYSTEM_INCLUDE_DIRECTORIES
    "${FORWARDING_HEADERS_DIR}/csseng"
)

list(APPEND number_SOURCES
    number.c
)

set(number_LIBRARIES
    CSSEng::CSSEng
)

CSSENG_EXECUTABLE(number)
CSSENG_COMPUTE_SOURCES(number)

# parseauto
CSSENG_EXECUTABLE_DECLARE(parseauto)

list(APPEND parseauto_PRIVATE_INCLUDE_DIRECTORIES
    "${CSSENG_DIR}"
)

list(APPEND parseauto_SYSTEM_INCLUDE_DIRECTORIES
    "${FORWARDING_HEADERS_DIR}/csseng"
)

list(APPEND parseauto_SOURCES
    parseauto.c
)

set(parseauto_LIBRARIES
    CSSEng::CSSEng
)

CSSENG_EXECUTABLE(parseauto)
CSSENG_COMPUTE_SOURCES(parseauto)

# parse2auto
CSSENG_EXECUTABLE_DECLARE(parse2auto)

list(APPEND parse2auto_PRIVATE_INCLUDE_DIRECTORIES
    "${CSSENG_DIR}"
)

list(APPEND parse2auto_SYSTEM_INCLUDE_DIRECTORIES
    "${FORWARDING_HEADERS_DIR}/csseng"
)

list(APPEND parse2auto_SOURCES
    parse2auto.c
)

set(parse2auto_LIBRARIES
    CSSEng::CSSEng
)

CSSENG_EXECUTABLE(parse2auto)
CSSENG_COMPUTE_SOURCES(parse2auto)

# select
CSSENG_EXECUTABLE_DECLARE(select)

list(APPEND select_PRIVATE_INCLUDE_DIRECTORIES
    "${CSSENG_DIR}"
)

list(APPEND select_SYSTEM_INCLUDE_DIRECTORIES
    "${FORWARDING_HEADERS_DIR}/csseng"
)

list(APPEND select_SOURCES
    select.c
)

set(select_LIBRARIES
    CSSEng::CSSEng
)

CSSENG_EXECUTABLE(select)
CSSENG_COMPUTE_SOURCES(select)

