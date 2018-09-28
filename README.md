#### 这是常用的cmake例子

#### 参照 http://www.hahack.com/codes/cmake/

#### 命令行常用代码:
* 编译执行
```
 cmake .
 make
 ```
* 交互编译执行
```
ccmake .
make
```
* 测试
```
    make test
 ```
* 安装,将生成的文件拷贝到指定路径
```
    make install
 ```
* 生成安装包
1. 生成二进制安装包
`cpack -C CPackConfig.cmake`
2. 生成源码安装包
`cpack -C CPackSourceConfig.cmake`
