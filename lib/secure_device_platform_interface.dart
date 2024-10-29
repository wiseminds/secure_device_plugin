import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'secure_device_method_channel.dart';

abstract class SecureDevicePlatform extends PlatformInterface {
  /// Constructs a SecureDevicePlatform.
  SecureDevicePlatform() : super(token: _token);

  static final Object _token = Object();

  static SecureDevicePlatform _instance = MethodChannelSecureDevice();

  /// The default instance of [SecureDevicePlatform] to use.
  ///
  /// Defaults to [MethodChannelSecureDevice].
  static SecureDevicePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SecureDevicePlatform] when
  /// they register themselves.
  static set instance(SecureDevicePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isEmulator(){
    throw UnimplementedError('Emulator() has not been implemented.');
  }

  Future<bool> isDevMode(){
    throw UnimplementedError("isDev() has not been implemented");
  }

  Future<bool> isJailBroken(){
    throw UnimplementedError("isDev() has not been implemented");
  }


}
