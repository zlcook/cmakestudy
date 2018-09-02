PROJECT(HELLO)
# 设置源文件目录，及编译后文件存放目录
ADD_SUBDIRECTORY(src bin)

# 安装文件到 share/doc/cmake/t2目录下
INSTALL(FILES COPYRIGHT README DESTINATION share/doc/cmake/t2)
# 安装脚本到bin目录下
INSTALL(PROGRAMS runhello.sh DESTINATION bin)
# 安装doc/目录下内容到 share/doc/cmake/t2目录下
INSTALL(DIRECTORY doc/ DESTINATION share/doc/cmake/t2)
