//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <wgpu/wgpu_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) wgpu_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "WgpuPlugin");
  wgpu_plugin_register_with_registrar(wgpu_registrar);
}
