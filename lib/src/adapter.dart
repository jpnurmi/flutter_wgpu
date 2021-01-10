import 'package:wgpu_ffi/wgpu_ffi.dart' as ffi;

export 'package:wgpu_ffi/wgpu_ffi.dart' show AdapterInfo, Limits;

class Adapter {
  final int _id;
  ffi.AdapterInfo? _info;
  ffi.Limits? _limits;

  Adapter(this._id);

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
