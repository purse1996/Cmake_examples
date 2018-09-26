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


#定制安装规则
#讲生成的Demo文件和MathFunctions库函数libMathFunctions.o复制到/usr/local/bin
#讲MathFunctions.h和config.h复制到/usr/local/include

install (TARGETS Demo DESTINATION bin)
install (FILES "${PROJECT_BINARY_DIR}/config.h" DESTINATION include)

#为工程添加测试
# 启用测试
enable_testing()

# 测试 5 的平方
add_test (test_5_2 Demo 5 2)
set_tests_properties (test_5_2
#PASS_REGULAR_EXPRESSION含义判断测试的输出结果是否包含后面的字符串
 PROPERTIES PASS_REGULAR_EXPRESSION "is 25")
# 测试 10 的 5 次方
add_test (test_10_5 Demo 10 5)
set_tests_properties (test_10_5
 PROPERTIES PASS_REGULAR_EXPRESSION "is 100000")
# 测试 2 的 10 次方
add_test (test_2_10 Demo 2 10)
set_tests_properties (test_2_10
 PROPERTIES PASS_REGULAR_EXPRESSION "is 1024")


 #为了简化测试，通过编写宏来测试:

 # 定义一个宏，用来简化测试工作
macro (do_test arg1 arg2 result)
  add_test (test_${arg1}_${arg2} Demo ${arg1} ${arg2})
  set_tests_properties (test_${arg1}_${arg2}
    PROPERTIES PASS_REGULAR_EXPRESSION ${result})
endmacro (do_test)

# 使用该宏进行一系列的数据测试
do_test (5 2 "is 25")
do_test (10 5 "is 100000")
do_test (2 10 "is 1024")


#支持gdb调试
#set(CMAKE_BUILD_TYPE "Debug")
#set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g -ggdb")
#set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")




