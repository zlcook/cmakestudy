#CMake ×îµÍ°æ±¾ÒªÇó
cmake_minimum_required (VERSION 2.8)

#Ï
project( Demo3)

aux_source_directory(. DIR_SRCS)

# add sub-directory
add_subdirectory(math)

#Ö¸¶¨Éú³ÉÄ¿±ê
add_executable(Demo3 ${DIR_SRCS})

# add link library
target_link_libraries(Demo3 MathFunctions)



