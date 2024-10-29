import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, visibleForTesting;
import 'package:flutter/services.dart';

import 'secure_device_platform_interface.dart';

/// An implementation of [SecureDevicePlatform] that uses method channels.
class MethodChannelSecureDevice extends SecureDevicePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('secure_device');

  @override
  Future<bool> isEmulator() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    bool isEmulator = false;

    if(defaultTargetPlatform == TargetPlatform.android){
      AndroidDeviceInfo androidDeviceInfo =  await deviceInfo.androidInfo;
      isEmulator = !androidDeviceInfo.isPhysicalDevice;
    }else if(defaultTargetPlatform == TargetPlatform.iOS){
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      isEmulator = !iosDeviceInfo.isPhysicalDevice;
    }

    return isEmulator;
  }

  @override
  Future<bool> isDevMode() async {
      return await methodChannel.invokeMethod("DEV_MODE");
  }

  @override
  Future<bool> isJailBroken() async{
      return await methodChannel.invokeMethod("JAIL_BREAK");
  }
}
