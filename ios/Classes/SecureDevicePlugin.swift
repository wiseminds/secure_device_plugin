import Flutter
import UIKit
import IOSSecuritySuite

public class SecureDevicePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "secure_device", binaryMessenger: registrar.messenger())
    let instance = SecureDevicePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "JAIL_BREAK"){
        result(IOSSecuritySuite.amIJailbroken())
    }
  }
}
