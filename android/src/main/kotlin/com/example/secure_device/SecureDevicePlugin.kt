package com.example.secure_device

import EmulatorCheck
import android.content.Context
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import com.example.secure_device.constant.EVENTS

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.jetbrains.annotations.NotNull


/** SecureDevicePlugin */
class SecureDevicePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "secure_device")
    channel.setMethodCallHandler(this)
  }

  @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR1)
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

    executeEvent(EVENTS.valueOf(call.method), result);

  }

  @RequiresApi(Build.VERSION_CODES.JELLY_BEAN_MR1)
  private fun executeEvent(event:EVENTS, result: Result) {

    result.success(
      when (event) {
        EVENTS.DEV_MODE -> {
          EmulatorCheck.isEmulator()
        }
        EVENTS.JAIL_BREAK -> {
          JailBreakDetection.isJailBroken(context)
        }
        EVENTS.IS_EMULATOR -> {
          DevelopmentModeCheck.developmentModeCheck(context)
        }

      }
    )

  }


  override fun onDetachedFromEngine(@NotNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}


