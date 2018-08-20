#CMake ×îµÍ°æ±¾ÒªÇó
cmake_minimum_required (VERSION 2.8)

#Ï
project( Demo2)

aux_source_directory(. DIR_SRCS)

#Ö¸¶¨Éú³ÉÄ¿±ê
add_executable(Demo2 ${DIR_SRCS})


