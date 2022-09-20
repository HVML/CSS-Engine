CSSEng -- a CSS parsing and selecting engine
============================================

Overview
--------

CSSEng is a CSS parsing and selecting engine.

This project is forked from <https://www.netsurf-browser.org/projects/libcss/>.
We integrate the original LibCSS, LibParserUtils, and LibWapcaplet into one repository and use cmake to build the library.

Requirements
------------

CSSEng requires the following tools:

+ CMake 3.15 or later
+ Python3 (3.6 or later, for generating selection code)
+ A C99 capable C compiler
+ Pkg-config
+ Perl (optional; for generating testcases)
+ [Check](https://github.com/libcheck/check) (optional; for test)

Building
--------

