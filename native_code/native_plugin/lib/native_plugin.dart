import 'dart:async';

import 'package:flutter/services.dart';
import 'dart:ffi';
import 'dart:io';

class NativePlugin {
  static const MethodChannel _channel = MethodChannel('native_plugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

final DynamicLibrary nativePluginLib = Platform.isAndroid
    ? DynamicLibrary.open('libnative_plugin.so')
    : DynamicLibrary.process();

final int Function(int x) getPrime = nativePluginLib
    .lookup<NativeFunction<Int32 Function(Int32)>>('getPrime')
    .asFunction();

final int Function(int x, int y) nativePlugin = nativePluginLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('native_plugin')
    .asFunction();
