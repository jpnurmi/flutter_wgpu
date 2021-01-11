cmake_minimum_required(VERSION 3.15)
set(PROJECT_NAME "wgpu")
project(${PROJECT_NAME} LANGUAGES CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "wgpu_plugin")

add_library(${PLUGIN_NAME} SHARED
  "wgpu_plugin.cpp"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter flutter_wrapper_plugin)

set(WGPU_LIB_NAME "wgpu_native.dll")
set(WGPU_DIR "${CMAKE_CURRENT_SOURCE_DIR}/wgpu")
set(WGPU_ARCH ${MSVC_CXX_ARCHITECTURE_ID})
set(WGPU_BUILD_TYPE "$<$<CONFIG:Debug>:debug>$<$<CONFIG:Release>:release>")
set(WGPU_LIB_DIR "${WGPU_DIR}/${WGPU_ARCH}/${WGPU_BUILD_TYPE}")
set(WGPU_LIB "${WGPU_LIB_DIR}/${WGPU_LIB_NAME}")

# List of absolute paths to libraries that should be bundled with the plugin
set(wgpu_bundled_libraries
  "${WGPU_LIB}"
  PARENT_SCOPE
)
