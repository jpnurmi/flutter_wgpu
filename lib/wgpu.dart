/// Experimental WebGPU plugin
library wgpu;

export 'src/adapter.dart';
export 'src/device.dart';
export 'src/webgpu.dart';

export 'package:wgpu_ffi/wgpu_ffi.dart'
    show AdapterInfo, Backend, Features, Limits, PowerPreference, RequestAdapterOptions;
