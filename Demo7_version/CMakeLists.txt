
set (Demo_VERSION_MAJOR 1)
set (Demo_VERSION_MINOR 0)

set( CMAKE_BUILD_TYPE "Debug")
set( CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g -ggdb")
set( CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")

#CMake ×îµÍ°æ±¾ÒªÇó
cmake_minimum_required (VERSION 2.8)

#Ï
project( Demo)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

#check system whether supporting pow of function
include (CheckFunctionExists)
check_function_exists (pow HAVE_POW)

check_function_exists (log HAVE_LOG)
check_function_exists (exp HAVE_EXP)

configure_file(
 "${PROJECT_SOURCE_DIR}/config.h.in"
 "${PROJECT_BINARY_DIR}/config.h"
)

if( NOT HAVE_POW )
 include_directories("${PROJECT_SOURCE_DIR}/math")
 add_subdirectory(math)
 set(EXTRA_LIBS ${EXTRA_LIBS} MathFunctions)

endif(NOT HAVE_POW)

aux_source_directory(. DIR_SRCS)


#Ö¸¶¨Éú³ÉÄ¿±ê
add_executable(Demo ${DIR_SRCS})

# add link library
target_link_libraries(Demo ${EXTRA_LIBS})


install(TARGETS Demo DESTINATION bin)
install(FILES "${PROJECT_BINARY_DIR}/config.h" DESTINATION include)


#enable test
enable_testing()

# test case
add_test(test_run Demo 5 2)

add_test( test_usage Demo)
set_tests_properties(test_usage PROPERTIES PASS_REGULAR_EXPRESSION "Usage: .* base exponent")

add_test( test_5_2 Demo 5 2)

set_tests_properties(test_5_2 PROPERTIES PASS_REGULAR_EXPRESSION "is 25")

#simplify coding by using macro
macro (do_test arg1 arg2 result)
  add_test(test_${arg1}_${arg2} Demo ${arg1} ${arg2})
  set_tests_properties( test_${arg1}_${arg2} PROPERTIES PASS_REGULAR_EXPRESSION ${result} )
endmacro(do_test)

 do_test(5 2 "is 25")
 do_test(6 2 "is 36")
 do_test(4 2 "is 16")
 do_test(3 2 "is 9" )
