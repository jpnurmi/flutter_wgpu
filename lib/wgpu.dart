/// Experimental WebGPU plugin
library wgpu;

export 'src/adapter.dart';
export 'src/device.dart';
export 'src/wgpu.dart';

export 'package:wgpu_native/wgpu_native.dart'
    show
        AdapterInfo,
        Backend,
        Features,
        Limits,
        PowerPreference,
        RequestAdapterOptions;
