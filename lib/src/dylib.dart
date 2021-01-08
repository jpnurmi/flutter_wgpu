import 'dart:ffi' as ffi;
import 'dart:io';

import 'bindings.dart';

LibWGPU? _dylib;
LibWGPU get dylib => _dylib ??= LibWGPU(
    ffi.DynamicLibrary.open(_resolveLibPath('wgpu_native', 'LIBWGPU_PATH')));

extension _StringWith on String {
  String prefixWith(String prefix) {
    if (isEmpty || startsWith(prefix)) return this;
    return prefix + this;
  }

  String suffixWith(String suffix) {
    if (isEmpty || endsWith(suffix)) return this;
    return this + suffix;
  }
}

String get _libPrefix => Platform.isWindows ? '' : 'lib';

String get _libSuffix {
  return Platform.isWindows
      ? '.dll'
      : Platform.isMacOS || Platform.isIOS
          ? '.dylib'
          : '.so';
}

String _fixupLibName(String libName) {
  return libName.prefixWith(_libPrefix).suffixWith(_libSuffix);
}

String _fixupLibPath(String libPath) => libPath.suffixWith('/');

bool _isFilePath(String path) {
  return path.isNotEmpty &&
      Directory(path).statSync().type == FileSystemEntityType.file;
}

String _resolveLibPath(String baseName, [String environmentVariable = '']) {
  var path = '';
  if (environmentVariable.isNotEmpty) {
    // allow specifying path to libwgpu_native.so via LIBWGPU_PATH Dart define
    // or environment variable
    final path = String.fromEnvironment(
      environmentVariable,
      defaultValue: Platform.environment[environmentVariable] ?? '',
    );

    // LIBWGPU_PATH=/path/to/libwgpu_native.so (full file path) specified
    if (_isFilePath(path)) return path;
  }

  // none or LIBWGPU_PATH=/path (just the path) specified
  return _fixupLibPath(path) + _fixupLibName(baseName);
}
