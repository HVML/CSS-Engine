set_property(DIRECTORY . PROPERTY FOLDER "CSSEng")

include(GlobalCommon)
include(MyMacros.cmake)

configure_file(include/purc-version.h.in ${CSSEng_DERIVED_SOURCES_DIR}/purc-version.h @ONLY)
configure_file(include/purc-features.h.in ${CSSEng_DERIVED_SOURCES_DIR}/purc-features.h @ONLY)

set(CSSEng_PRIVATE_INCLUDE_DIRECTORIES
    "${CMAKE_BINARY_DIR}"
    "${CSSENG_DIR}"
    "${CSSENG_DIR}/include"
    "${CSSEng_DERIVED_SOURCES_DIR}"
    "${FORWARDING_HEADERS_DIR}"
    "${CMAKE_BINARY_DIR}/Source/CSSEng"
)

# TODO: List the headers should be installed to system here.
set(CSSEng_INSTALLED_HEADERS
    "${CSSEng_DERIVED_SOURCES_DIR}/purc-version.h"
    "${CSSEng_DERIVED_SOURCES_DIR}/purc-features.h"
    "${CSSENG_DIR}/include/purc-macros.h"
    "${CSSENG_DIR}/include/purc-errors.h"
    "${CSSENG_DIR}/include/purc-variant.h"
    "${CSSENG_DIR}/include/purc-rwstream.h"
    "${CSSENG_DIR}/include/purc-utils.h"
    "${CSSENG_DIR}/include/purc-dom.h"
    "${CSSENG_DIR}/include/purc-html.h"
    "${CSSENG_DIR}/include/purc-ports.h"
    "${CSSENG_DIR}/include/purc-pcrdr.h"
    "${CSSENG_DIR}/include/purc-helpers.h"
    "${CSSENG_DIR}/include/purc-dvobjs.h"
    "${CSSENG_DIR}/include/purc-runloop.h"
    "${CSSENG_DIR}/include/purc-executor.h"
    "${CSSENG_DIR}/include/purc-document.h"
    "${CSSENG_DIR}/include/purc.h"
)

# TODO: List the directorires which do not contain any platform-dependent C source files
set(CSSEng_PLATFORM_INDEPENDENT_DIRS
    "instance"
    "utils"
    "variant"
    "html"
    "dom"
    "dvobjs"
    "dvobjs/parsers"
    "vcm"
    "ejson"
    "hvml"
    "vdom"
    "executors"
    "executors/parsers"
    "interpreter"
    "fetchers"
    "pcrdr"
    "document"
)

# This macro will append all C/CXX source files in ${CSSEng_PLATFORM_INDEPENDENT_DIRS}
# to ${CSSEng_SOURCES}
APPEND_ALL_SOURCE_FILES_IN_DIRLIST(CSSEng_SOURCES "${CSSEng_PLATFORM_INDEPENDENT_DIRS}")

# TODO: List the source files individually.
list(APPEND CSSEng_SOURCES
    "${CSSENG_DIR}/ports/vasprintf.c"
    "${CSSENG_DIR}/ports/misc.c"
)

# Put the CXX source files which can be unified in `Sources.txt`
list(APPEND CSSEng_UNIFIED_SOURCE_LIST_FILES
    "Sources.txt"
)

set(CSSEng_LIBRARIES)
set(CSSEng_DEPENDENCIES)

# TODO: the source files and libraries for optional features.
if (ENABLE_WEBSOCKET)
    list(APPEND CSSEng_UNIFIED_SOURCE_LIST_FILES
        "SourcesWebSocket.txt"
    )
    list(APPEND CSSEng_PRIVATE_INCLUDE_DIRECTORIES
    )
    list(APPEND CSSEng_SOURCES 
    )
endif ()

if (ENABLE_LSQL)
    list(APPEND CSSEng_LIBRARIES SQLite::SQLite3)
endif ()

if (ENABLE_XML)
    list(APPEND CSSEng_LIBRARIES LibXml2::LibXml2)
endif ()

set(CSSEng_INTERFACE_LIBRARIES CSSEng)
set(CSSEng_INTERFACE_INCLUDE_DIRECTORIES ${CSSEng_PRIVATE_FRAMEWORK_HEADERS_DIR})

CSSENG_FRAMEWORK_DECLARE(CSSEng)
CSSENG_INCLUDE_CONFIG_FILES_IF_EXISTS()

set(_parsers
        exe_key exe_range exe_filter
        exe_char exe_token
        exe_add exe_sub exe_mul exe_div exe_formula exe_objformula
        exe_sql exe_travel
        exe_func exe_class
        match_for
        ejson)
CSSENG_PARSERS_GEN_IN(executors/parsers "${_parsers}" "")
unset(_parsers)

set(_parsers logical)
CSSENG_PARSERS_GEN_IN(dvobjs/parsers "${_parsers}" "")
unset(_parsers)

# Generate constants for HTML ns/tags/interfaces
add_custom_command(
    OUTPUT "${CSSEng_DERIVED_SOURCES_DIR}/html_foo.c"
        ${CSSEng_DERIVED_SOURCES_DIR}/ns_const.h
        ${CSSEng_DERIVED_SOURCES_DIR}/ns_res.h
        ${CSSEng_DERIVED_SOURCES_DIR}/html_tag_const.h
        ${CSSEng_DERIVED_SOURCES_DIR}/html_tag_res.h
        ${CSSEng_DERIVED_SOURCES_DIR}/html_interface_res.h
        ${CSSEng_DERIVED_SOURCES_DIR}/html_tag_res_ext.h
    MAIN_DEPENDENCY ${CSSENG_DIR}/html/tags.py
    DEPENDS ${CSSENG_DIR}/html/interfaces.py
            ${CSSENG_DIR}/html/ns_const.h.in
            ${CSSENG_DIR}/html/ns_res.h.in
            ${CSSENG_DIR}/html/html_interface_res.h.in
            ${CSSENG_DIR}/html/html_tag_res_ext.h.in
            ${CSSENG_DIR}/html/html_tag_const.h.in
            ${CSSENG_DIR}/html/html_tag_res.h.in
    COMMAND ${Python3_EXECUTABLE} ${CSSENG_DIR}/html/tags.py "${CSSEng_DERIVED_SOURCES_DIR}" --without-print
    COMMAND touch "${CSSEng_DERIVED_SOURCES_DIR}/html_foo.c"
    COMMENT "Generating files for HTML tags and interfaces by using ${Python3_EXECUTABLE}"
    WORKING_DIRECTORY "${CSSENG_DIR}/html/"
    VERBATIM)
list(APPEND CSSEng_SOURCES ${CSSEng_DERIVED_SOURCES_DIR}/html_foo.c)

# Generate constants for HTML attributes
add_custom_command(
    OUTPUT "${CSSEng_DERIVED_SOURCES_DIR}/html_attr_foo.c" "${CSSEng_DERIVED_SOURCES_DIR}/html_attr_res.h" "${CSSEng_DERIVED_SOURCES_DIR}/html_attr_const.h"
    MAIN_DEPENDENCY ${CSSENG_DIR}/html/attr.py
    DEPENDS ${CSSENG_DIR}/html/attr_res.h.in ${CSSENG_DIR}/html/attr_const.h.in
    COMMAND ${Python3_EXECUTABLE} ${CSSENG_DIR}/html/attr.py "${CSSEng_DERIVED_SOURCES_DIR}" --without-print
    COMMAND touch "${CSSEng_DERIVED_SOURCES_DIR}/html_attr_foo.c"
    COMMENT "Generating html_attr_res.h and html_attr_const.h by using ${Python3_EXECUTABLE}"
    WORKING_DIRECTORY "${CSSENG_DIR}/html/"
    VERBATIM)
list(APPEND CSSEng_SOURCES ${CSSEng_DERIVED_SOURCES_DIR}/html_attr_foo.c)

# Copy str_res.h.in to DerivedSources
add_custom_command(
    OUTPUT "${CSSEng_DERIVED_SOURCES_DIR}/html_bar.c" "${CSSEng_DERIVED_SOURCES_DIR}/str_res.h"
    COMMAND ${CMAKE_COMMAND} -E copy "${CSSENG_DIR}/html/str_res.h.in"
        "${CSSEng_DERIVED_SOURCES_DIR}/str_res.h"
    COMMAND touch "${CSSEng_DERIVED_SOURCES_DIR}/html_bar.c"
    DEPENDS "${CSSENG_DIR}/html/str_res.h.in"
    COMMENT "Copying str_res.h.in to DerivedSources"
    VERBATIM)
list(APPEND CSSEng_SOURCES ${CSSEng_DERIVED_SOURCES_DIR}/html_bar.c)

# Generate keywords table for hvml language
set(_kw_h           "${CSSEng_DERIVED_SOURCES_DIR}/keywords.h")
set(_kw_inc         "${CSSEng_DERIVED_SOURCES_DIR}/keywords.inc")
set(_kw_foo         "${CSSEng_DERIVED_SOURCES_DIR}/keywords-foo.c")
set(_kw_py          "${CSSENG_DIR}/instance/make-keywords-table.py")
set(_kw_txt         "${CSSENG_DIR}/instance/data/keywords.txt")
set(_kw_h_in        "${CSSENG_DIR}/instance/data/keywords.h.in")
set(_kw_inc_in      "${CSSENG_DIR}/instance/data/keywords.inc.in")
add_custom_command(
    OUTPUT "${_kw_foo}"
           "${_kw_h}"
           "${_kw_inc}"
    MAIN_DEPENDENCY "${_kw_py}"
    DEPENDS "${_kw_txt}"
            "${_kw_h_in}"
            "${_kw_inc_in}"
    COMMAND "${Python3_EXECUTABLE}" "${_kw_py}"
            "--dest" "${CSSEng_DERIVED_SOURCES_DIR}"
            "--kw_h"        "${_kw_h}"
            "--kw_inc"      "${_kw_inc}"
            "--kw_foo"      "${_kw_foo}"
            "--kw_txt"      "${_kw_txt}"
            "--kw_h_in"     "${_kw_h_in}"
            "--kw_inc_in"   "${_kw_inc_in}"
            "--without-print"
    COMMAND touch "${_kw_foo}"
    COMMENT "Generating keywords.h/keywords.inc by using ${Python3_EXECUTABLE}"
    WORKING_DIRECTORY "${CSSENG_DIR}/instance/"
    VERBATIM)
list(APPEND CSSEng_SOURCES ${_kw_foo})
unset(_kw_h)
unset(_kw_inc)
unset(_kw_foo)
unset(_kw_py)
unset(_kw_txt)
unset(_kw_h_in)
unset(_kw_inc_in)

# Generate attrs table for hvml parser
add_custom_command(
    OUTPUT "${CSSEng_DERIVED_SOURCES_DIR}/hvml-attr-foo.c"
           "${CSSEng_DERIVED_SOURCES_DIR}/hvml-attr-static-list.inc"
    MAIN_DEPENDENCY ${CSSENG_DIR}/hvml/make-attrs-table.py
    DEPENDS "${CSSENG_DIR}/hvml/data/attrs.txt"
            "${CSSENG_DIR}/hvml/data/attr-static-list.inc.in"
    COMMAND ${Python3_EXECUTABLE} ${CSSENG_DIR}/hvml/make-attrs-table.py "${CSSEng_DERIVED_SOURCES_DIR}" --without-print
    COMMAND touch "${CSSEng_DERIVED_SOURCES_DIR}/hvml-attr-foo.c"
    COMMENT "Generating hvml-attr-static-list.inc by using ${Python3_EXECUTABLE}"
    WORKING_DIRECTORY "${CSSENG_DIR}/hvml/"
    VERBATIM)
list(APPEND CSSEng_SOURCES ${CSSEng_DERIVED_SOURCES_DIR}/hvml-attr-foo.c)

# Generate tags table for hvml parser
add_custom_command(
    OUTPUT "${CSSEng_DERIVED_SOURCES_DIR}/hvml-tag-foo.c"
           "${CSSEng_DERIVED_SOURCES_DIR}/hvml-tag-static-list.inc"
           "${CSSEng_DERIVED_SOURCES_DIR}/hvml-tag.h"
    MAIN_DEPENDENCY ${CSSENG_DIR}/hvml/make-tags-table.py
    DEPENDS "${CSSENG_DIR}/hvml/data/tags.txt"
            "${CSSENG_DIR}/hvml/data/tag-static-list.inc.in"
            "${CSSENG_DIR}/hvml/data/tag.h.in"
    COMMAND ${Python3_EXECUTABLE} ${CSSENG_DIR}/hvml/make-tags-table.py "${CSSEng_DERIVED_SOURCES_DIR}" --without-print
    COMMAND touch "${CSSEng_DERIVED_SOURCES_DIR}/hvml-tag-foo.c"
    COMMENT "Generating hvml-tag-static-list.inc/hvml-tag.h by using ${Python3_EXECUTABLE}"
    WORKING_DIRECTORY "${CSSENG_DIR}/hvml/"
    VERBATIM)
list(APPEND CSSEng_SOURCES ${CSSEng_DERIVED_SOURCES_DIR}/hvml-tag-foo.c)

add_custom_command(
    OUTPUT "${CSSEng_DERIVED_SOURCES_DIR}/purc-error-except.c"
           "${CSSEng_DERIVED_SOURCES_DIR}/generic_err_msgs.inc"
           "${CSSEng_DERIVED_SOURCES_DIR}/executor_err_msgs.inc"
           "${CSSEng_DERIVED_SOURCES_DIR}/variant_err_msgs.inc"
           "${CSSEng_DERIVED_SOURCES_DIR}/ejson_err_msgs.inc"
           "${CSSEng_DERIVED_SOURCES_DIR}/rwstream_err_msgs.inc"
           "${CSSEng_DERIVED_SOURCES_DIR}/hvml_err_msgs.inc"
           "${CSSEng_DERIVED_SOURCES_DIR}/pcrdr_err_msgs.inc"
    MAIN_DEPENDENCY ${BUILD_TOOLS_DIR}/make-error-info.py
    DEPENDS "${CSSENG_DIR}/instance/generic.error.in"
            ${CSSENG_DIR}/executors/executor.error.in
            ${CSSENG_DIR}/variant/variant.error.in
            ${CSSENG_DIR}/ejson/ejson.error.in
            ${CSSENG_DIR}/utils/rwstream.error.in
            ${CSSENG_DIR}/hvml/hvml.error.in
            ${CSSENG_DIR}/pcrdr/pcrdr.error.in
    COMMAND ${Python3_EXECUTABLE} ${BUILD_TOOLS_DIR}/make-error-info.py "${CSSEng_DERIVED_SOURCES_DIR}"
            ${CSSENG_DIR}/instance/generic.error.in
            ${CSSENG_DIR}/executors/executor.error.in
            ${CSSENG_DIR}/variant/variant.error.in
            ${CSSENG_DIR}/ejson/ejson.error.in
            ${CSSENG_DIR}/utils/rwstream.error.in
            ${CSSENG_DIR}/hvml/hvml.error.in
            ${CSSENG_DIR}/pcrdr/pcrdr.error.in
    COMMAND touch "${CSSEng_DERIVED_SOURCES_DIR}/purc-error-except.c"
    COMMENT "Generating *_err_msgs.inc by using ${Python3_EXECUTABLE}"
    WORKING_DIRECTORY "${CSSENG_DIR}/instance/"
    VERBATIM)
list(APPEND CSSEng_SOURCES ${CSSEng_DERIVED_SOURCES_DIR}/purc-error-except.c)


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
        DESTINATION "${HEADER_INSTALL_DIR}/purc"
)
