import 'dart:async';

import 'package:flutter/services.dart';

class FilepickerMacos {
  static const MethodChannel _channel = MethodChannel('filepicker_macos');

  static Future<List<String>> pickFile() async {
    final List list = await _channel.invokeMethod('pickFiles');
    return list.map((e) => e.toString()).toList(growable: false);
  }

  static Future<List<String>> pickDir() async {
    final List list = await _channel.invokeMethod('pickDir');
    return list.map((e) => e.toString()).toList(growable: false);
  }
}
