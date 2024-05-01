# RibbonTemplate
## 1. About 关于
This is an app template for users who want to use `RibbonUI`.
这是一个为希望将`RibbonUI`应用于自己程序的开发者准备的项目模板。

For more information about `RibbonUI`, please see [this](https://github.com/mentalfl0w/RibbonUI).
希望了解更多关于`RibbonUI`的信息，请访问[这个](https://github.com/mentalfl0w/RibbonUI)链接。

## 2. How to use it? 如何使用它？
+ Before Install 安装前准备
  
  To install Qt 6, it is recommended to install the **Qt 6.6.3** version via the official online installer, **installing via brew, etc. may cause problems**. **Qt Quick related modules** and the **qt5compat qtshadertools qtimageformats** component are required
  
  安装Qt 6，推荐通过官方在线安装器安装**Qt 6.6.3版本**，**通过brew等方式安装可能会出现问题**。**Qt Quick相关模块**和**qt5compat qtshadertools qtimageformats**组件是必要的。

+ Compile the example and library 编译例程和库
  - Clone and enter the library folder 下载仓库并进入
    ```shell
    git clone https://github.com/mentalfl0w/RibbonTemplate.git --recursive
    cd RibbonUI
    ```
  - Add your source files and edit the `CMakeLists.txt` 添加你自己的源文件并修改`CMakeLists.txt`
  - Create and enter the build folder 创建并进入build文件夹
    ```shell
    mkdir build
    cd build
    ```
  - Build 编译
    ```shell
    # if you want to make a Debug build, just let -DCMAKE_BUILD_TYPE=Debug, --config Debug
    # if you want a static build, add -DRIBBONUI_BUILD_STATIC_LIB=ON into command
    cmake -DCMAKE_MESSAGE_LOG_LEVEL=STATUS -DCMAKE_PREFIX_PATH=/Users/runner/work/RibbonTemplate/Qt/6.6.3/macos  -DCMAKE_BUILD_TYPE=Release -GNinja ..
    # -DCMAKE_PREFIX_PATH={YOUR QT INSTALL FOLDER}
    cmake --build . --target all --config Release --parallel
    ```
