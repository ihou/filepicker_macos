import 'package:flutter/material.dart';

import 'package:filepicker_macos/filepicker_macos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: pickFiles,
              child: const Text("PickFiles"),
            ),
            TextButton(
              onPressed: pickDir,
              child: const Text("PickDir"),
            ),
            TextButton(
              onPressed: pickPng,
              child: const Text("PickPng"),
            ),
          ],
        ),
      ),
    );
  }

  void pickFiles() {
    FilepickerMacos.pickFiles();
  }

  void pickDir() {
    FilepickerMacos.pickDir();
  }

  void pickPng() {
    FilepickerMacos.pick(
      allowedFileTypes: ["png"],
      canChooseDirectories: false,
      directoryURL: "~/Documents",
    );
  }
}
