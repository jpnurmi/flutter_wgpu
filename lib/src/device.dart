import 'package:wgpu_native/wgpu_native.dart' as n;

class Device {
  final int _id;
  n.Limits? _limits;

  Device(this._id);

  int get id => _id;

  int get features => n.wgpu_device_features(_id);

  n.Limits get limits => _limits ??= n.wgpu_device_limits(_id);

  void destroy() => n.wgpu_device_destroy(_id);

  void dispose() => _limits?.dispose();
}
