import 'dart:async';

import 'package:wgpu_native/wgpu_native.dart' as n;

import 'adapter.dart';

class WGPU {
  static Future<Adapter> requestAdapter({
    n.PowerPreference? powerPreference,
    int? backends,
  }) async {
    final c = Completer<Adapter>();
    n.wgpu_request_adapter_async(
      n.RequestAdapterOptions(
        powerPreference: powerPreference ?? n.PowerPreference.defaultPower,
      ),
      backends ?? n.Backend.empty,
      true,
      (int id) => c.complete(Adapter(id)),
    );
    return c.future;
  }
}
