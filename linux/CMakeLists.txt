cmake_minimum_required(VERSION 3.10)
set(PROJECT_NAME "wgpu")
project(${PROJECT_NAME} LANGUAGES CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "wgpu_plugin")

add_library(${PLUGIN_NAME} SHARED
  "wgpu_plugin.cc"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_include_directories(${PLUGIN_NAME} PRIVATE
  "${CMAKE_CURRENT_SOURCE_DIR}/wgpu")
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter)
target_link_libraries(${PLUGIN_NAME} PRIVATE PkgConfig::GTK)

set(WGPU_LIB_NAME "libwgpu_native.so")
set(WGPU_DIR "${CMAKE_CURRENT_SOURCE_DIR}/wgpu")
set(WGPU_ARCH ${CMAKE_SYSTEM_PROCESSOR})
string(TOLOWER ${CMAKE_BUILD_TYPE} WGPU_BUILD_TYPE)
set(WGPU_LIB_DIR "${WGPU_DIR}/${WGPU_ARCH}/${WGPU_BUILD_TYPE}")
set(WGPU_LIB "${WGPU_LIB_DIR}/${WGPU_LIB_NAME}")

target_link_libraries(${PLUGIN_NAME} PRIVATE ${WGPU_LIB})

# List of absolute paths to libraries that should be bundled with the plugin
set(wgpu_bundled_libraries
  ${WGPU_LIB}
  PARENT_SCOPE
)
