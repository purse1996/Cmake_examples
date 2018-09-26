cmake_minimum_required(VERSION 2.8)

project(Demo6)


#检查系统平台是否存在pow函数
include(${CMAKE_ROOT}/Modules/CheckFunctionExists.cmake)
check_function_exists(pow HAVE_POW)

#添加一个配置文件 设置预定义参数
#PROJECT_SOURCE_DIR已经定义好的变量 代表项目根目录
# config.h中预设了USE_MYMATH 同事为了便于命令设置 我们通过config.h.in
configure_file(
    "${PROJECT_SOURCE_DIR}/config.h.in"
    "${PROJECT_SOURCE_DIR}/config.h")



#是否加入MathFunctions库
if(NOT HAVE_POW)
include_directories("${PROJECT_SOURCE_DIR}/math")
add_subdirectory(math)
#使用EXTRA_LIBS为所有的库函数
set(EXTRA_LIBS ${EXTRA_LIBS} MathFunctions)
endif(NOT HAVE_POW)

aux_source_directory(. DIR_SOURCE)
add_executable(Demo ${DIR_SOURCE})
target_link_libraries(Demo ${EXTRA_LIBS})


#定制安装规则
#讲生成的Demo文件和MathFunctions库函数libMathFunctions.o复制到/usr/local/bin
#讲MathFunctions.h和config.h复制到/usr/local/include

install (TARGETS Demo DESTINATION bin)
install (FILES "${PROJECT_BINARY_DIR}/config.h" DESTINATION include)

# 启用测试
enable_testing()

# 测试程序是否成功运行
add_test (test_run Demo 5 2)

# 测试帮助信息是否可以正常提示
add_test (test_usage Demo)
set_tests_properties (test_usage
  PROPERTIES PASS_REGULAR_EXPRESSION "Usage: .* base exponent")

# 定义一个宏，用来简化测试工作
macro (do_test arg1 arg2 result)
  add_test (test_${arg1}_${arg2} Demo ${arg1} ${arg2})
  set_tests_properties (test_${arg1}_${arg2}
    PROPERTIES PASS_REGULAR_EXPRESSION ${result})
endmacro (do_test)

# 利用 do_test 宏，测试一系列数据
do_test (5 2 "is 25")
do_test (10 5 "is 100000")
do_test (2 10 "is 1024")




