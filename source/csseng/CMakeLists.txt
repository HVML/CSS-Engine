set_property(DIRECTORY . PROPERTY FOLDER "CSSEng")

include(GlobalCommon)
include(MyMacros.cmake)

set(CSSEng_PRIVATE_INCLUDE_DIRECTORIES
    "${CMAKE_BINARY_DIR}"
    "${CSSENG_DIR}"
    "${CSSENG_DIR}/include"
    "${CSSEng_DERIVED_SOURCES_DIR}"
    "${FORWARDING_HEADERS_DIR}"
    "${CMAKE_BINARY_DIR}/source/csseng"
)

# TODO: List the headers should be installed to system here.
set(CSSEng_INSTALLED_HEADERS
    "${CSSENG_DIR}/include/computed.h"
    "${CSSENG_DIR}/include/errors.h"
    "${CSSENG_DIR}/include/font_face.h"
    "${CSSENG_DIR}/include/fpmath.h"
    "${CSSENG_DIR}/include/functypes.h"
    "${CSSENG_DIR}/include/hint.h"
    "${CSSENG_DIR}/include/parserutils.h"
    "${CSSENG_DIR}/include/properties.h"
    "${CSSENG_DIR}/include/select.h"
    "${CSSENG_DIR}/include/stylesheet.h"
    "${CSSENG_DIR}/include/types.h"
    "${CSSENG_DIR}/include/wapcaplet.h"
    "${CSSENG_DIR}/include/csseng.h"
)

# TODO: List the directorires which do not contain any platform-dependent C source files
set(CSSEng_PLATFORM_INDEPENDENT_DIRS
    "wapcaplet"
    "parser-charset"
    "parser-input"
    "parser-utils"
    "bytecode/"
    "charset"
    "css"
    "lex"
    "parse"
    "select"
    "utils"
)

# This macro will append all C/CXX source files in ${CSSEng_PLATFORM_INDEPENDENT_DIRS}
# to ${CSSEng_SOURCES}
APPEND_ALL_SOURCE_FILES_IN_DIRLIST(CSSEng_SOURCES "${CSSEng_PLATFORM_INDEPENDENT_DIRS}")

# TODO: List the source files individually.
list(APPEND CSSEng_SOURCES
)

# Put the CXX source files which can be unified in `Sources.txt`
list(APPEND CSSEng_UNIFIED_SOURCE_LIST_FILES
    "Sources.txt"
)

set(CSSEng_LIBRARIES)
set(CSSEng_DEPENDENCIES)

set(CSSEng_INTERFACE_LIBRARIES CSSEng)
set(CSSEng_INTERFACE_INCLUDE_DIRECTORIES ${CSSEng_PRIVATE_FRAMEWORK_HEADERS_DIR})

CSSENG_FRAMEWORK_DECLARE(CSSEng)
CSSENG_INCLUDE_CONFIG_FILES_IF_EXISTS()

CSSENG_WRAP_SOURCELIST(${CSSEng_SOURCES})

CSSENG_COPY_FILES(CSSEng_CopyPrivateHeaders
    DESTINATION ${CSSEng_PRIVATE_FRAMEWORK_HEADERS_DIR}/CSSEng
    FILES ${CSSEng_PRIVATE_FRAMEWORK_HEADERS}
    FLATTENED
)
list(APPEND CSSEng_INTERFACE_DEPENDENCIES CSSEng_CopyPrivateHeaders)
# CSSEng_CopyPrivateHeaders needs to have a direct or indirect
# dependency of CSSEng target for CMake Visual Studio generator to
# eliminate duplicated custom commands. Otherwise, CSSPropertyNames.h
# will be generated in both projects.
if (NOT INTERNAL_BUILD)
    add_dependencies(CSSEng_CopyPrivateHeaders CSSEng)
    add_dependencies(CSSEng WTF)
endif ()

CSSENG_COMPUTE_SOURCES(CSSEng)
CSSENG_FRAMEWORK(CSSEng)
CSSENG_FRAMEWORK_TARGET(CSSEng)

# The -ftree-sra optimization (implicit with -O2) causes crashes when
# allocating large chunks of memory using bmalloc on Intel 32bit.
# See https://bugs.webkit.org/show_bug.cgi?id=146440
string(TOLOWER ${CMAKE_HOST_SYSTEM_PROCESSOR} LOWERCASE_CMAKE_HOST_SYSTEM_PROCESSOR)
if (CMAKE_COMPILER_IS_GNUCXX AND "${LOWERCASE_CMAKE_HOST_SYSTEM_PROCESSOR}" MATCHES "(i[3-6]86|x86)$")
    CSSENG_ADD_TARGET_CXX_FLAGS(CSSEng -fno-tree-sra)
endif ()

if (${CSSEng_LIBRARY_TYPE} MATCHES "SHARED")
    set_target_properties(CSSEng PROPERTIES VERSION ${PROJECT_VERSION} SOVERSION ${PROJECT_VERSION_MAJOR})
    install(TARGETS CSSEng DESTINATION "${LIB_INSTALL_DIR}")
endif ()

if (MSVC)
    set_target_properties(CSSEng PROPERTIES
        COMPILE_PDB_NAME ${CSSEng_OUTPUT_NAME}
    )
endif ()

# add_subdirectory(res)

install(TARGETS CSSEng
        DESTINATION "${LIB_INSTALL_DIR}/"
)

install(FILES ${CSSEng_INSTALLED_HEADERS}
        DESTINATION "${HEADER_INSTALL_DIR}/csseng"
)
