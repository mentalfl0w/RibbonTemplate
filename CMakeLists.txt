cmake_minimum_required(VERSION 3.21)

# Edit your App name here
project(RibbonUITemplate VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/.cmake/)

if(QT_VERSION VERSION_GREATER_EQUAL "6.3")
    qt_standard_project_setup()
    qt_policy(SET QTP0001 NEW)
else()
    set(CMAKE_AUTOMOC ON)
    set(CMAKE_AUTORCC ON)
    set(CMAKE_AUTOUIC ON)
endif()

# For macOS's Universal Build(Will deprecated after WWDC 2024 because Apple will possibly stop the support of Intel Mac.)
if(APPLE)
    set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64" CACHE STRING "" FORCE)
endif()

set(RIBBONUI_BUILD_EXAMPLES OFF)
add_subdirectory(3rdparty/RibbonUI) # Add RibbonUI into build tree

string(TIMESTAMP TIME_YEAR %Y)
set(PROJECT_COMPANY "Mentalflow's Lab") # Edit to your company name
set(PROJECT_COPYRIGHT "Copyright (c) ${TIME_YEAR} Mentalflow's Lab. All rights reserved.") # Edit to your copyright content
set(PROJECT_DOMAIN "dev.ourdocs.cn.ribbontemplate") # Edit to your domain
set(PROJECT_BUNDLE_NAME RibbonUITemplate) # Edit the executable file name here

find_package(Qt6 COMPONENTS Quick REQUIRED) # Find your needed packages

set(sources_files source/main.cpp) # Add your source files here, list all source files is RECOMMEND because it's more clear for maintenance
set(qml_files qml/template.qml qml/about.qml qml/components/RibbonMessageListViewExample.qml) # Add your QML files here
set(resource_files resources/imgs/heart.png resources/imgs/search.png) # Add your resource files here

if(CMAKE_BUILD_TYPE STREQUAL "Debug") # Set the app's output dir
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/output/debug)
else()
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/output/release)
endif()

if (WIN32)
    configure_file(.cmake/win_app.rc.in ${CMAKE_BINARY_DIR}/win_app.rc) # Configure Windows' rc file
    set(app_icon_resource_windows ${CMAKE_BINARY_DIR}/win_app.rc)
    qt_add_executable(${PROJECT_NAME}
        ${sources_files}
        ${app_icon_resource_windows}
    )
    file(TO_CMAKE_PATH "/" PATH_SEPARATOR)
    if(MSVC)
        set(DLLPATH ${CMAKE_SOURCE_DIR}/3rdparty/msvc/*.dll)
    else()
        set(DLLPATH ${CMAKE_SOURCE_DIR}/3rdparty/mingw/*.dll)
    endif()
    string(REPLACE "/" ${PATH_SEPARATOR} DLLPATH "${DLLPATH}")
    file(GLOB DLL_FILES ${DLLPATH})
    # Copy the necessary dlls for app
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy
        ${DLL_FILES}
        ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    )
elseif(APPLE)
    set(MACOSX_BUNDLE_GUI_IDENTIFIER ${PROJECT_DOMAIN})
    set(MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION})
    set(MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR})
    set(MACOSX_BUNDLE_BUNDLE_NAME ${PROJECT_BUNDLE_NAME})
    set(MACOSX_BUNDLE_COPYRIGHT ${PROJECT_COPYRIGHT})
    set(MACOSX_BUNDLE_DEVELOPMENT_REGION "Chinese") # Edit to your mother language
    set(CMAKE_OSX_DEPLOYMENT_TARGET "11.0" CACHE STRING "Minimum macOS deployment version" FORCE)
    set(MACOSX_BUNDLE_EXECUTABLE_NAME ${PROJECT_BUNDLE_NAME})
    set(MACOSX_BUNDLE_ICON_FILE AppIcon) # Edit to your icon file name， NO POSTFIX
    configure_file(.cmake/MacOSXBundleInfo.plist.in ${CMAKE_BINARY_DIR}/Info.plist) # Configure macOS Info.plist
    set(App_ICON "${PROJECT_SOURCE_DIR}/resources/imgs/AppIcon.icns") # Edit to your icon file routine
    set_source_files_properties(${App_ICON} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
    qt_add_executable(${PROJECT_NAME}
        ${sources_files}
        ${App_ICON}
    )
else()
    qt_add_executable(${PROJECT_NAME}
        ${sources_files}
    )
endif()

qt_add_qml_module(${PROJECT_NAME}
    URI ${PROJECT_NAME}
    VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    RESOURCE_PREFIX "/qt/qml/"
    QML_FILES ${qml_files}
    RESOURCES ${resource_files}
)

set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_INFO_PLIST ${CMAKE_BINARY_DIR}/Info.plist
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    OUTPUT_NAME ${PROJECT_BUNDLE_NAME}
)

set(version_str "${PROJECT_VERSION_MAJOR},${PROJECT_VERSION_MINOR},${PROJECT_VERSION_PATCH}")
target_compile_definitions(${PROJECT_NAME} PRIVATE RIBBONTEMPLATE_VERSION=${version_str}) # If you need to get app version in source files, edit this
target_compile_definitions(${PROJECT_NAME} PRIVATE RIBBONTEMPLATE_URI="${PROJECT_NAME}") # If you use custom QML module URI, REMEMBER edit this

if(RIBBONUI_BUILD_STATIC_LIB)
    target_link_libraries(${PROJECT_NAME} PRIVATE
        RibbonUIplugin
    )
    target_compile_definitions(${PROJECT_NAME} PRIVATE
        RIBBONUI_BUILD_STATIC_LIB
    )
else()
    if(WIN32)
        if (MINGW)
            add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
                COMMAND ${CMAKE_COMMAND} -E copy_if_different
                "${RIBBONUI_QML_PLUGIN_DIRECTORY}/RibbonUI.dll"
                ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
        else()
            if (NOT RIBBONUI_BUILD_STATIC_LIB)
                if (CMAKE_BUILD_TYPE MATCHES "Debug")
                    set(DEBUG_POSTFIX "d")
                endif()
                add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
                    COMMAND ${CMAKE_COMMAND} -E copy_if_different
                    "${RIBBONUI_QML_PLUGIN_DIRECTORY}/RibbonUI${DEBUG_POSTFIX}.dll"
                    ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
            endif()
        endif()
    endif()
endif()

target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt::Quick
    RibbonUI
)

target_compile_definitions(${PROJECT_NAME} PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/include) # add `include` dir to include path

