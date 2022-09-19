# css
list(APPEND examples_INCLUDE_DIRECTORIES
    ${CMAKE_SOURCE_DIR}/include
    ${CMAKE_SOURCE_DIR}/include
)

list(APPEND examples_SOURCES
    example1.c
)

include_directories(${examples_INCLUDE_DIRECTORIES})
add_executable(examples ${examples_SOURCES})
target_link_libraries(examples CSSEng:CSSEng)
