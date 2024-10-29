import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:secure_device/secure_device_method_channel.dart';

void main() {
  MethodChannelSecureDevice platform = MethodChannelSecureDevice();
  const MethodChannel channel = MethodChannel('secure_device');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return true;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });


  test('JAIL_BREAK', () async {
    expect(await platform.isJailBroken(), true);
  });

  test('DEV_MODE', () async {
    expect(await platform.isDevMode(), true);
  });
}
