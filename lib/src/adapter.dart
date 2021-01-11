import 'package:wgpu_native/wgpu_native.dart' as n;

import 'device.dart';

class Adapter {
  final int _id;
  n.AdapterInfo? _info;
  n.Limits? _limits;

  Adapter(this._id);

  int get id => _id;

  int get features => n.wgpu_adapter_features(_id);

  n.AdapterInfo get info => _info ??= n.wgpu_adapter_get_info(_id);

  n.Limits get limits => _limits ??= n.wgpu_adapter_limits(_id);

  void destroy() => n.wgpu_adapter_destroy(_id);

  void dispose() {
    _info?.dispose();
    _limits?.dispose();
  }

  Device requestDevice({
    int? features,
    n.Limits? limits,
    bool? sharedValidation,
    String? tracePath,
  }) {
    return Device(n.wgpu_adapter_request_device(
      _id,
      features ?? 0,
      limits ?? n.Limits(),
      sharedValidation ?? false,
      tracePath ?? '',
    ));
  }
}
