cmake_minimum_required( VERSION 2.8)

project(Demo3)

aux_source_directory(. DIR_SOURCE)

#使得子目录中的cmake文件和源文件也会被执行
add_subdirectory(math)

add_executable(Demo ${DIR_SOURCE})

#添加链接库
target_link_libraries(Demo MathFunctions)

