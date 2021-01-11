#include "include/wgpu/wgpu_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <glib.h>
#include <gtk/gtk.h>

static const char* kLibWgpuPath = "LIBWGPU_PATH";
static const char* kLibWgpuSo = "libwgpu_native.so";

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

// Gets the directory the current executable is in, borrowed from:
// https://github.com/flutter/engine/blob/master/shell/platform/linux/fl_dart_project.cc#L27
//
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in https://github.com/flutter/engine/blob/master/LICENSE.
static gchar* get_executable_path() {
  g_autoptr(GError) error = nullptr;
  g_autofree gchar* exe_path = g_file_read_link("/proc/self/exe", &error);
  if (exe_path == nullptr) {
    g_critical("Failed to determine location of executable: %s",
               +error->message);
    return nullptr;
  }
  return g_path_get_dirname(exe_path);
}

static bool hasenv(const char* name) {
  const char* value = getenv(name);
  return value && strlen(value) > 0;
}

void wgpu_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  WgpuPlugin* plugin =
      WGPU_PLUGIN(g_object_new(wgpu_plugin_get_type(), nullptr));

  if (!hasenv(kLibWgpuPath)) {
    g_autofree gchar* exe_path = get_executable_path();
    g_autofree gchar* libwgpu_path =
        g_build_filename(exe_path, "lib", kLibWgpuSo, nullptr);
    g_setenv(kLibWgpuPath, libwgpu_path, 0);
  }

  g_object_unref(plugin);
}
