import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:secure_device/secure_device.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String deviceInformation = 'Unknown';
  bool isEmulator = false;
  bool isDeveloperMode = false;
  bool isDeviceRooted = false;

  final _secureDevicePlugin = SecureDevice();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool isEmulatorDevice;
    bool isDevMode;
    bool isRooted;

    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {



      //deviceInfo = await _secureDevicePlugin.getDeviceInfo() ?? 'Unknown device info';
      isEmulatorDevice = await _secureDevicePlugin.isEmulator();
      isDevMode = await _secureDevicePlugin.isDevMode();
      isRooted = await _secureDevicePlugin.isJailBroken();


    } on PlatformException {
      isEmulatorDevice = false;
      isDevMode = false;
      isRooted = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {
    //   deviceInformation = deviceInfo;
    // });

    setState(() {
      isEmulator = isEmulatorDevice;
    });

    setState(() {
      isDeveloperMode = isDevMode;
    });

    setState(() {
      isDeviceRooted = isRooted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(
        children: [
          Text("isEmulator: $isEmulator"),
          Text("isDevMode: $isDeveloperMode"),
          Text("isRooted: $isDeviceRooted")
        ],
      ),
    ));
  }
}
