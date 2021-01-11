import Cocoa
import FlutterMacOS
import Foundation

public class WgpuPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    if getenv("LIBWGPU_PATH") == nil {
      setenv("LIBWGPU_PATH", Bundle.main.privateFrameworksPath! + "/wgpu.framework/Resources/libwgpu_native.dylib", 0);
    }

    let channel = FlutterMethodChannel(name: "wgpu", binaryMessenger: registrar.messenger)
    let instance = WgpuPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
