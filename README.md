#### 这是常用的cmake例子

#### 参照 http://www.hahack.com/codes/cmake/

#### 命令行常用代码:
1. 编译执行
    cmake .
    make
2 交互编译执行
    ccmake .
    make
3 测试
    make test
4 安装,将生成的文件拷贝到指定路径
    make install
5 生成安装包
    生成二进制安装包
    cpack -C CPackConfig.cmake
    生成源码安装包
    cpack -C CPackSourceConfig.cmake
