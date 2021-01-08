import 'src/bindings.dart';
import 'src/dylib.dart';

class WebGPU {
  static LibWGPU get lib => dylib;
}
