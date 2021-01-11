import 'package:wgpu_ffi/wgpu_ffi.dart' as ffi;

class Device {
  final int _id;
  ffi.Limits? _limits;

  Device(this._id);

  int get id => _id;

  int get features => ffi.wgpu_device_features(_id);

  ffi.Limits get limits => _limits ??= ffi.wgpu_device_limits(_id);

  void destroy() => ffi.wgpu_device_destroy(_id);

  void dispose() => _limits?.dispose();
}
