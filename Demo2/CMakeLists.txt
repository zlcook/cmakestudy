#CMake ��Ͱ汾Ҫ��
cmake_minimum_required (VERSION 2.8)

#�
project( Demo2)

aux_source_directory(. DIR_SRCS)

#ָ������Ŀ��
add_executable(Demo2 ${DIR_SRCS})


