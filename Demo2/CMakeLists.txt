cmake_minimum_required(VERSION 2.8)
project(Demo2)

#语法 aux_source_directory(<dir> 变量名) 查找目录下所有源文件 存储在变量名中
aux_source_directory(. DIR_SOURCE)

add_executable(Demo ${DIR_SOURCE})
