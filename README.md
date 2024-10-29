# Secure Device Plugin

The Secure Device plugin provides a Flutter interface to detect and identify potential security risks on iOS and Android devices. It allows developers to check if a device is running in an emulator, if it is in developer mode, and if an iOS device has been jailbroken. By leveraging this plugin, you can enhance the security of your Flutter applications and implement appropriate measures to protect against unauthorized access and tampering.

## Features

The Secure Device plugin offers the following features:

- Emulator Detection: Check if the app is running on an emulator.
- Developer Mode Detection: Determine if the app is running on a device in developer mode.
- Jailbreak Detection: Identify if an iOS device has been jailbroken.

## Usage

To use this plugin, follow these steps:

1. Import the Secure Device plugin:
```dart
import 'package:secure_device/secure_device.dart';

SecureDevice secureDevice = SecureDevice();

bool isEmulator = await secureDevice.isEmulator();
bool isDevMode = await secureDevice.isDevMode();
bool isJailBroken = await secureDevice.isJailBroken();

```


#Example

You can find a complete example in the example directory of this repository. The example demonstrates how to use the Secure Device plugin to perform device security checks.
Notes

    Emulator detection is supported on both iOS and Android platforms.
    Developer mode detection is only available on Android devices.
    Jailbreak detection is applicable to iOS devices only.

#Issues and Contributions

Please report any issues you encounter using the plugin on the GitHub issue tracker. Contributions, such as bug fixes and new features, are welcomed and encouraged. You can submit a pull request to contribute to the project.
License

This plugin is released under the MIT License. See the LICENSE file for more details.
