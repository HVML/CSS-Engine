CSSEngine -- a CSS parser and selection engine
===============================================

Overview
--------

CSSEngine is a CSS parser and selection engine. It aims to parse the forward compatible CSS grammar.

This project is forked from <https://www.netsurf-browser.org/projects/libcss/>.
We integrate the original LibCSS, LibParserUtils, and LibWapcaplet into this repository and use cmake to build the code.

Requirements
------------

CSSEngine requires the following tools:

   + CMake 
   + A C99 capable C compiler
   + GNU make or compatible
   + Pkg-config
   + Perl (for the testcases)
   + Python3 (minimum 3.6, for generated selection code)

Building
--------

