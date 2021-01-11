import 'dart:async';

import 'package:wgpu_ffi/wgpu_ffi.dart' as ffi;

import 'adapter.dart';

class WGPU {
  static Future<Adapter> requestAdapter({
    ffi.PowerPreference? powerPreference,
    int? backends,
  }) async {
    final c = Completer<Adapter>();
    ffi.wgpu_request_adapter_async(
      ffi.RequestAdapterOptions(
        powerPreference: powerPreference ?? ffi.PowerPreference.defaultPower,
      ),
      backends ?? ffi.Backend.empty,
      true,
      (int id) => c.complete(Adapter(id)),
    );
    return c.future;
  }
}
