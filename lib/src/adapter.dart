import 'dart:async';

import 'package:wgpu_ffi/wgpu_ffi.dart' as ffi;

class Adapter {
  final int _id;
  ffi.AdapterInfo? _info;
  ffi.Limits? _limits;

  Adapter(this._id);

  static Future<Adapter> request({
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

  int get id => _id;

  int get features => ffi.wgpu_adapter_features(_id);

  ffi.AdapterInfo get info => _info ??= ffi.wgpu_adapter_get_info(_id);

  ffi.Limits get limits => _limits ??= ffi.wgpu_adapter_limits(_id);

  void destroy() => ffi.wgpu_adapter_destroy(_id);

  void dispose() {
    _info?.dispose();
    _limits?.dispose();
  }
}
