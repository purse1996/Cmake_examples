cmake_minimum_required(VERSION 2.8)

project(Demo4)


#是否使用自己编译的MathFunctions库
option(USE_MYMATH
    "use my math function" ON)

#添加一个配置文件 设置预定义参数
#PROJECT_SOURCE_DIR已经定义好的变量 代表项目根目录
# config.h中预设了USE_MYMATH 同事为了便于命令设置 我们通过config.h.in
configure_file(
    "${PROJECT_SOURCE_DIR}/config.h.in"
    "${PROJECT_SOURCE_DIR}/config.h")



#是否加入MathFunctions库
if(USE_MYMATH)
include_directories("${PROJECT_SOURCE_DIR}/math")
add_subdirectory(math)
#使用EXTRA_LIBS为所有的库函数
set(EXTRA_LIBS ${EXTRA_LIBS} MathFunctions)
endif(USE_MYMATH)

aux_source_directory(. DIR_SOURCE)
add_executable(Demo ${DIR_SOURCE})
target_link_libraries(Demo ${EXTRA_LIBS})

