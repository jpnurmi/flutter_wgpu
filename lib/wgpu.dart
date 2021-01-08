
import 'dart:async';

import 'package:flutter/services.dart';

class Wgpu {
  static const MethodChannel _channel =
      const MethodChannel('wgpu');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
