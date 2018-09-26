aux_source_directory(. DIR_LIB_SOURCE)

add_library(MathFunctions ${DIR_LIB_SOURCE})

#定制安装规则
#讲生成的Demo文件和MathFunctions库函数libMathFunctions.o复制到/usr/local/bin
#讲MathFunctions.h和config.h复制到/usr/local/include
install (TARGETS MathFunctions DESTINATION bin)
install (FILES MathFunctions.h DESTINATION include)
