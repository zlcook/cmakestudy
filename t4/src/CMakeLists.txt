
# set search path of hello.h . gcc -o main main.c -I/home/supdev/work/cmakestudy/installdir/include/hello 
INCLUDE_DIRECTORIES(/home/supdev/work/cmakestudy/installdir/include/hello)

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)

# You can also use the following method instead, but you must set CMAKE_INCLUDE_PATH of evn variable
#FIND_PATH(myheader hello.h)
#IF(myHeader)
#INCLUDE_DIRECTORIES(${myheader})
#ENDIF(myHeader)


#set search path of hello.so .The premise of using this method is that you must set CMAKE_LIBRARY_PATH of env variable
FIND_LIBRARY(mylib hello)

IF(mylib)
LINK_DIRECTORIES( ${mylib} )
MESSAGE(STATUS "find hello.so: ${mylib}")
ELSE(mylib)
MESSAGE(FATAL_ERROR "can't find hello.so")
ENDIF(mylib)


# the command has to be behind Link_DIRECTORIES
ADD_EXECUTABLE(main main.c)

TARGET_LINK_LIBRARIES(main ${mylib})

INSTALL(TARGETS main RUNTIME DESTINATION bin/t4)
