#include "include/wgpu/wgpu_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>

#define WGPU_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), wgpu_plugin_get_type(), WgpuPlugin))

struct _WgpuPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(WgpuPlugin, wgpu_plugin, g_object_get_type())

static void wgpu_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(wgpu_plugin_parent_class)->dispose(object);
}

static void wgpu_plugin_class_init(WgpuPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = wgpu_plugin_dispose;
}

static void wgpu_plugin_init(WgpuPlugin* self) {}

void wgpu_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  WgpuPlugin* plugin =
      WGPU_PLUGIN(g_object_new(wgpu_plugin_get_type(), nullptr));

  g_object_unref(plugin);
}
