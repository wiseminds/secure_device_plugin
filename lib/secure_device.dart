
import 'secure_device_platform_interface.dart';

class SecureDevice {

  Future<bool> isEmulator(){
    return SecureDevicePlatform.instance.isEmulator();
  }

  Future<bool> isDevMode(){
    return SecureDevicePlatform.instance.isDevMode();
  }

  Future<bool> isJailBroken(){
    return SecureDevicePlatform.instance.isJailBroken();
  }
}
