import 'package:flutter_test/flutter_test.dart';
import 'package:secure_device/secure_device.dart';
import 'package:secure_device/secure_device_platform_interface.dart';
import 'package:secure_device/secure_device_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSecureDevicePlatform
    with MockPlatformInterfaceMixin
    implements SecureDevicePlatform {


  @override
  Future<bool> isDevMode() => Future.value(true);

  @override
  Future<bool> isEmulator() => Future.value(true);

  @override
  Future<bool> isJailBroken() => Future.value(true);
}

void main() {
  final SecureDevicePlatform initialPlatform = SecureDevicePlatform.instance;

  test('$MethodChannelSecureDevice is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSecureDevice>());
  });

  test('All test', () async {
    SecureDevice secureDevicePlugin = SecureDevice();
    MockSecureDevicePlatform fakePlatform = MockSecureDevicePlatform();
    SecureDevicePlatform.instance = fakePlatform;

    expect(await secureDevicePlugin.isDevMode(), true);
    expect(await secureDevicePlugin.isJailBroken(), true);
    expect(await secureDevicePlugin.isEmulator(), true);
  });
}
