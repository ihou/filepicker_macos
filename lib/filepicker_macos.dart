import 'dart:async';

import 'package:flutter/services.dart';

class FilepickerMacos {
  static const MethodChannel _channel = MethodChannel('filepicker_macos');

  static Future<List<String>> pick({
    String? prompt,
    String? message,
    String? directoryURL,
    List<String>? allowedFileTypes,
    bool canChooseDirectories = true,
    bool canChooseFiles = true,
    bool canCreateDirectories = true,
    bool allowsMultipleSelection = true,
  }) async {
    var arguments = {
      "prompt": prompt,
      "message": message,
      "directoryURL": directoryURL,
      "allowedFileTypes": allowedFileTypes,
      "canChooseDirectories": canChooseDirectories,
      "canChooseFiles": canChooseFiles,
      "canCreateDirectories": canCreateDirectories,
      "allowsMultipleSelection": allowsMultipleSelection,
    };
    final List list = await _channel.invokeMethod('pick', arguments);
    return list.map((e) => e.toString()).toList(growable: false);
  }

  static Future<List<String>> pickFiles() async {
    final List list = await pick(directoryURL: "~/Downloads");
    return list.map((e) => e.toString()).toList(growable: false);
  }

  static Future<String?> pickDir({String? prompt, String? directory}) async {
    final List list = await pick(
        canChooseFiles: false,
        allowsMultipleSelection: false,
        directoryURL: directory ?? "~/Downloads",
        prompt: prompt);
    if (list.isEmpty) {
      return null;
    }
    return list.map((e) => e.toString()).toList(growable: false).first;
  }
}
