cmake_minimum_required (VERSION 2.8)

PROJECT(HELLOLIB)
ADD_SUBDIRECTORY(lib)
INSTALL(FILES COPYRIGHT README DESTINATION share/doc/cmake/t3)

INSTALL(DIRECTORY doc/ DESTINATION share/doc/cmake/t3)
